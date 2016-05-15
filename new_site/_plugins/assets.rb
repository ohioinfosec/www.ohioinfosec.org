require 'jekyll'
require 'liquid'
require 'digest/md5'
require 'zlib'
require 'yui/compressor'
require 'fileutils'

module Jekyll

  puts "Compiling Assets..."

  # Remove old assets
  if File.exists?("assets")
    FileUtils.rm_r("assets")
  end

  # Create directories
  Dir.mkdir "assets"
  Dir.mkdir "assets/css"
  Dir.mkdir "assets/js"
  Dir.mkdir "assets/fonts"

  # Collect all files in _assets folders
  ASSET_FILES_CSS = Dir.glob(File.join("_assets/css","*")).sort
  ASSET_FILES_JS = Dir.glob(File.join("_assets/js","*")).sort
  ASSET_FILES_FONTS = Dir.glob(File.join("_assets/fonts","*")).sort

  # Process CSS into one file
  File.open("assets/css/stylesheet-uncompressed.css", "w") do |output_file|
    ASSET_FILES_CSS.each do |input_file|
      File.open(input_file) do |file|
        file.each { |line| output_file.puts line }
      end
    end
  end

  # Compress the CSS File
  File.open("assets/css/stylesheet.css", "w") do |output_file|
    output_file.puts YUI::CssCompressor.new.compress(File.open("assets/css/stylesheet-uncompressed.css","r"))
  end

  File.delete("assets/css/stylesheet-uncompressed.css")

  # MD5-tag the CSS file
  CSS_HASH = Digest::MD5.new.file(File.open("assets/css/stylesheet.css","r")).hexdigest
  CSS_FILENAME = "assets/css/stylesheet-" + CSS_HASH + ".css"
  File.rename("assets/css/stylesheet.css",CSS_FILENAME)

  # Gzip the CSS file
  Zlib::GzipWriter.open(CSS_FILENAME + ".gz") do |gz|
    gz.mtime = File.mtime(CSS_FILENAME)
    gz.orig_name = CSS_FILENAME
    gz.write IO.binread(CSS_FILENAME)
  end

  # Process JS into one file
  File.open("assets/js/javascript-uncompressed.js", "w") do |output_file|
    ASSET_FILES_JS.each do |input_file|
      File.open(input_file) do |file|
        file.each { |line| output_file.puts line }
      end
    end
  end

  # Compress the CSS File
  File.open("assets/js/javascript.js", "w") do |output_file|
    output_file.puts YUI::JavaScriptCompressor.new(:munge => true).compress(File.open("assets/js/javascript-uncompressed.js","r"))
  end

  File.delete("assets/js/javascript-uncompressed.js")

  # MD5-tag the CSS file
  JS_HASH = Digest::MD5.new.file(File.open("assets/js/javascript.js","r")).hexdigest
  JS_FILENAME = "assets/js/javascript-" + JS_HASH + ".js"
  File.rename("assets/js/javascript.js",JS_FILENAME)

  # Gzip the CSS file
  Zlib::GzipWriter.open(JS_FILENAME + ".gz") do |gz|
    gz.mtime = File.mtime(JS_FILENAME)
    gz.orig_name = JS_FILENAME
    gz.write IO.binread(JS_FILENAME)
  end

  # Copy the fonts folder, as it is referenced directly by the CSS

  ASSET_FILES_FONTS.each do |font|
    FileUtils.cp(font,"assets/fonts/")
  end
  copied_fonts = ASSET_FILES_FONTS
  copied_fonts.each do |item|
    item.tr!("_","")
  end
  copied_fonts.each do |copied_font|
    Zlib::GzipWriter.open(copied_font + ".gz") do |gz|
      gz.mtime = File.mtime(copied_font)
      gz.orig_name = copied_font
      gz.write IO.binread(copied_font)
    end
  end

  class RenderCSSTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
    end
    def render(context)
      "<link rel=\"stylesheet\" href=\"/#{CSS_FILENAME}\">"
    end
  end

  class RenderJSTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text
    end
    def render(context)
      "<script src=\"/#{JS_FILENAME}\"></script>"
    end
  end
end
Liquid::Template.register_tag('css_tag', Jekyll::RenderCSSTag)
Liquid::Template.register_tag('js_tag', Jekyll::RenderJSTag)
