require 'jekyll'

desc "Deploy website via rsync"
task :deploy do
  puts "## Building Site"
  system("jekyll build")
  puts "## Deploying website via Rsync"
  system("rsync -avz --delete _site/ badmin@ohioinfosec.org:/var/www/www.ohioinfosec.org")
end

desc "Create a new post"
task :new_post do
  post_number = Jekyll::Site.new(Jekyll.configuration).posts.docs.length + 1
  puts "Post title?"
  title = STDIN.gets.chomp
  puts "Categories?"
  categories = STDIN.gets.chomp.gsub(/\w+/, &:capitalize).split
  filetitle = title.downcase.gsub(/[\'\":\?\.\#]/,'').gsub(/\s/,'-')
  date = Time.now
  filedate = date.strftime('%Y-%m-%d')
  filename = filedate + "-" + filetitle + ".md"
  open("_posts/"+filename, 'a') do |file|
    file.puts "---"
    file.puts "layout: post"
    file.puts "title: " + "\"" + title + "\""
    file.puts "date: " + date.strftime('%F %T %Z')
    file.puts "categories: " + "[" + categories.join(", ") + "]"
    file.puts "navbar: "
    file.puts "---"
    file.puts "\n"
  end
  puts "Happy blogging!"
end

desc "Create a new top-level page"
task :new_page do
  puts "Page title?"
  title = STDIN.gets.chomp
  dirname = title.downcase.gsub(/[\'\":\?\.]/,'').gsub(/\s/,'-')
  Dir.mkdir(dirname)
  open(dirname+"/index.md", 'a') do |file|
    file.puts "---"
    file.puts "layout: default"
    file.puts "title: " + "\"" + title + "\""
    file.puts "navbar: "
    file.puts "---"
    file.puts "\n"
  end
  puts "Happy blogging!"
end
