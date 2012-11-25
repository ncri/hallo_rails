# Hallo Rails

Use the Hallo Editor (https://github.com/bergie/hallo) to edit content in place in your Rails app.

## Requirements

jQuery and jQuery UI and styles for the editor icons (recommended is the icon font Font Awesome). A good way of including jQuery UI in your rails app is using the jquery-ui-rails gem.


## Installation

Add this line to your application's Gemfile:

    gem 'hallo_rails'

And then execute:

    $ bundle

Add this to your javascript manifest file:

    //= require rangy-core
    //= require hallo
    //= require hallo_rails

Add this to your sass styles:

    @import 'hallo_rails';

You also need to supply styles for the editor icons. 
Good icons are included in http://fortawesome.github.com/Font-Awesome/

Just download it and add the styles and font files to your app and you are good to go.


## Basic Usage

Hallo Rails provides 2 view helpers to make Rails model fields editable.
Say you have an article model with a field 'content'. Outside a form use:

    = editable @article, :content

Within a form use 

    = form_editable @article, :content

And make sure to call 

    HalloRails.init() 

after the dom has loaded, e.g. like:

    jQuery ->
      HalloRails.init()

Hallo Rails will save edited content each time the editable area is left, using the default rails url for updating models:

    "#{object_name.pluralize}/#{object.to_param}" 

For the article example this could be for example: "articles/24".

You can change this url by supplying it to the editable helper:

    = editable @article, :content, update_url: "my_own/url/to_update/the/model"

If you use the form_editable helper, the content is only saved once the form is submitted.


## Advanced usage

Check the source code ;-)   (for now)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
