require 'jekyll'
require 'active_support/core_ext/integer/inflections' # Required for 'ordinalize'.

desc "Deploy website via rsync"
task :deploy do
  puts "## Building Site"
  system("jekyll build")
  puts "## Deploying website via Rsync"
  system("rsync -avz --delete _site/ oisf@www.ohioinfosec.org:~/www")
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

desc "Create a new meeting agenda"
task :new_agenda do
  puts "Meeting Date? (YYYY-MM-DD)"
  date_input = STDIN.gets.chomp
  time = Time.parse(date_input)
  ordinal_time = time.strftime("%B #{time.day.ordinalize}, %Y")
  filename = time.strftime("%F")+"-agenda.md"
  open("_posts/"+filename, 'a') do |file|
    file.puts "---"
    file.puts "layout: post"
    file.puts "navbar: Blog"
    file.puts "title: \"Meeting Agenda - #{ordinal_time}\""
    file.puts "date: #{time.strftime("%F")} 12:00:00 -0400"
    file.puts "comments: true"
    file.puts "categories: Agenda"
    file.puts "---"
    file.puts
    file.puts "**6:00pm:**"
    file.puts
    file.puts "Food and drinks served"
    file.puts
    file.puts "### Introduction"
    file.puts
    file.puts "A brief overview of the Ohio Information Security Forum."
    file.puts
    file.puts "### **PRESENTATION TITLE**"
    file.puts "_By: [PRESENTOR NAME](https://www.example.com)_"
    file.puts
    file.puts "#### Abstract"
    file.puts
    file.puts "TEXT HERE"
    file.puts
    file.puts "#### Bio"
    file.puts
    file.puts "TEXT HERE"
    file.puts
    file.puts "### **PRESENTATION TITLE**"
    file.puts "_By: [PRESENTOR NAME](https://www.example.com)_"
    file.puts
    file.puts "#### Abstract"
    file.puts
    file.puts "TEXT HERE"
    file.puts
    file.puts "#### Bio"
    file.puts
    file.puts "TEXT HERE"
  end
end

desc "Create some new meeting notes"
task :new_notes do
  puts "Meeting Date? (YYYY-MM-DD)"
  date_input = STDIN.gets.chomp
  time = Time.parse(date_input)
  ordinal_time = time.strftime("%B #{time.day.ordinalize}, %Y")
  filename = time.strftime("%F")+"-meeting-notes.md"
  open("_posts/"+filename, 'a') do |file|
    file.puts "---"
    file.puts "layout: post"
    file.puts "navbar: Blog"
    file.puts "title: \"Meeting Notes - #{ordinal_time}\""
    file.puts "date: #{time.strftime("%F")} 21:00:00 EST"
    file.puts "comments: true"
    file.puts "categories: Notes"
    file.puts "---"
    file.puts
    file.puts "Make sure to use [our Amazon Smile](https://smile.amazon.com/ch/26-1330537)"
    file.puts "link. It doesn't cost you anything extra and a portion of the price goes to"
    file.puts "OISF. It's a simple way to keep us running."
    file.puts
    file.puts "NOTES GO HERE"
  end
end
