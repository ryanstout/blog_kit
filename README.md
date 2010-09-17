BlogKit
=======

BlogKit is a rails plugin to add a blog to your app.  The goal is to provide common blog
functionality that integrates into your existing app while keeping things simple.

BlogKit has the following features.

+ Admin for Blog Articles
+ Search engine friendly urls
+ Uses existing user model
+ Comments via existing user model
+ Highlights code (with ultraviolet)
+ Uses your existing layouts
+ Easily customizable css
+ Akismet (spam filtering) Support
+ Markdown (default) or just plain html parsing
+ Image and Gravatar support
+ Anonymous Comments (optional)
+ Atom Feeds
+ Tags
+ Image upload (via paperclip, or something that adds has_attached_file to models)
    + S3 Image support


Coming Soon:

+ Follow comments (via e-mail)

Install for Rails3
==================

in rails:

    rails plugin install git://github.com/ryanstout/blog_kit.git -r rails3

The plugin will then copy in migrations for the BlogPost and BlogComment models.  Install the tables with:

    rake db:migrate

The blog_kit configuration file will be installed in config/blog_kit.yml, you can enable and disable features there.

An editable CSS file for the blog pages will be copied into public/stylesheets/blog_kit.css

CSS files for the code highlighter will be copied into public/stylesheets/syntax/
    
Then you will want to make sure your app meets the setup requirements below.

Assumptions
===========

BlogKit makes the following assumptions

+ flash messages displaying is handled via the layout


Setup
=====

BlogKit is designed to work with your existing user model, at the moment, it assumes this will be
called User.  Your User class and application controller simply need to respond to some methods to
be able to use BlogKit.  These methods, while not standardized are very common, and come with plugins
like Authlogic and restful_authentication.

ApplicationController should respond to:
    #require_user
    #current_user
    #title - (optional passes in the pages title as the first argument)

User model should respond to:
    #admin?  - returns true if the user can edit posts and delete comments
    #name	 - the users name
    #blog_image_url (optional, the users photo, show next to comments/posts)
    #email (options - for gravatar support)
    
Once you have everything setup, you can see and manage the blog at /blog_posts  Make sure that you have
all of the requirements below met.

Rails 3 is supported via the rails3 branch, if you are using legacy routing, you may need to copy in routes
from config/routes.rb to your main routes.rb file.

To be able to use the delete links on posts, you will need to add the following to the top of your layout:

    <%= csrf_meta_tag %>

Also be sure that you have the proper javascript handling code for link_to '', :method => destroy

Requirements
============

Rails 3.x

- Will_Paginate

Optional:

- Ultraviolet (and its deps, for code highlighting)

    Install Oniguruma if 1.8.x
    http://www.geocities.jp/kosako3/oniguruma/
    
    source 'http://gems.github.com'
    gem "spox-ultraviolet", :require => false
    
- BlueCloth 2 (for markdown)

    gem 'bluecloth'

- Paperclip

    gem 'paperclip', :git => 'http://github.com/thoughtbot/paperclip.git', :branch => 'rails3'

Customization
=============

Be sure to edit config/blog_kit.yml, many common settings can be changed there.

** View Customization **

BlogKit is built as a rails engine plugin (for rails 2.3.x, not the previous engines plugin).  You can see
the models, views, and controllers in vendor/plugins/blog_kit/app/  You can change them by copying any of 
them into your apps /app directory.  Rails will look in /app before looking in vendor/plugins/blog_kit/app/
Once they are copied into /app, you can customize the appearance/behavior of the blog pages.

Troubleshooting
===============

Q. Creating a blog post does not work, it instead renders the index page.
A. Make sure you aren't using the old style default routes in rails (match '/:controller(/:action(/:id))')
   If you are using default routes, then simply copy the following into your routes.rb file before the default route

  	resources :blog_posts do
		resources :blog_comments
		resources :blog_images
		
		collection do
			get :drafts
		end
		
		member do
			get :tag
		end
	end

Tag List
========

By default, the layout does not display a list of all tags.  This can be easily added to any layout in the 
application by including this in the controller:

    helper :blog

Then in the view:

    <%= blog_tags_list %>
    
You can optionally pass in a limit on the number of tags to show.

Also keep in mind that you can specify a layout just for the blog kit pages.

Titles
======

You can have blog_kit set the page title, just create a method in application_helper like:

    def title(ttl)
        @page_title = ttl
    end

If anyone knows of a better convention for this, let me know.  This is what nifty_generators uses

Code Highlighting Example
=========================

To get code highlighted, place the following tag:

    <code lang="ruby">

    </code>

You can find a list of languages (syntaxes) under doc/SYNTAXES and a list of themes (colors) under
doc/THEMES


Copyright (c) 2010 Ryan Stout, released under the MIT license
