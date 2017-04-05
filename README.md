# The OISF Website

This site is created with [Jekyll](http://jekyllrb.com/). It's a pretty
straightforward site, no weirdness. Just review the [Jekyll
docs](http://jekyllrb.com/docs/home/) to understand how to modify/update it.

## Initial Setup

This site is using _Ruby 2.4.1_. Make sure you have that installed using
something like [RVM](https://rvm.io/) or [RBENV](https://github.com/rbenv/rbenv)
(with [ruby-build](https://github.com/rbenv/ruby-build)). To install the needed
libraries, make sure you have [Bundler](http://bundler.io/) installed with `gem
install bundler`. Then run `bundle install`. The included `Gemfile` will specify
all required versions and libraries needed.

**Note:** Jekyll can be tempermental about updating Gems, you might need to do
some work if you want to update to the latest library versions with `bundle
update`.

## Creating a New Agenda

Use `rake new_agenda` to create a new meeting agenda file. The file is created with the "Agenda" category, which will automatically add the contents to the `agenda.md` file. You don't need to edit that file. Just look in the `_posts` directory for the newly-created file and edit away!

## Creating Meeting Notes

Use `rake new_notes` to create a new meeting notes file. The file will be
created in the `_posts` directory.

## Previewing the Site

Use `jekyll serve` to preview the site locally at
[http://localhost:4000/](http://localhost:4000/] ). Make sure to exit the
preview before deploying with `CTRL+C`, or else your links will be messed up.

## Deploying the Site

Use `rake deploy` to build the site and rsync it over to Tom's server. The
details of these commands can be found in the `Rakefile`.
