BlogKit
=======

BlogKit is a rails plugin to add a blog to your app.  It has the following features.

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

Coming Soon:

+ Tags
+ Image upload


Install
=======

in rails:

    ./script/plugin install git@github.com:ryanstout/blog_kit.git

The plugin will then copy in migrations for the BlogPost and BlogComment models.  Install the tables with:

    rake db:migrate

The blog_kit configuration file will be installed in config/blog_kit.yml, you can enable and disable features there.

An editable CSS file for the blog pages will be copied into public/stylesheets/blog_kit.css

CSS files for the code highlighter will be copied into public/stylesheets/syntax/
    
Then you will want to make sure your app meets the setup requirements below.

Setup
=====

BlogKit is designed to work with your existing user model, at the moment, it assumes this will be
called User.  Your User class and application controller simply need to respond to some methods to
be able to use BlogKit.  These methods, while not standardized are very common, and come with plugins
like Authlogic and restful_authentication.

ApplicationController should respond to:
    #require_user
    #current_user

User model should respond to:
    #admin?  - returns true if the user can edit posts and delete comments
    #name	 - the users name
    #blog_image_url (optional)
    #email (options - for gravatar support)

Requirements
============

Rails 2.3.x (Rails 3 support coming soon)

- Will_Paginate

Optional:

- Ultraviolet (and its deps, for code highlighting)
- BlueCloth 2 (for markdown)


Code Highlighting Example
=======

To get code highlighted, place the following tag:

    <code lang="ruby">

    </code>

Available Themes
================
active4d
all_hallows_eve
amy
blackboard
brilliance_black
brilliance_dull
cobalt
dawn
eiffel
espresso_libre
idle
iplastic
lazy
mac_classic
magicwb_amiga
pastels_on_dark
slush_poppies
spacecadet
sunburst
twilight
zenburnesque


Copyright (c) 2010 Ryan Stout, released under the MIT license


/script/plugin install --revision "tag 1.0.1" http://github.com/dasil003/tm_syntax_highlighting.git