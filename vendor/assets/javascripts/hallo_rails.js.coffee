
default_options =
  toolbarPositionAbove: true

default_plugins =
  halloformat: {}
  halloblock: {}
  hallolists: {}
  hallolink: {}
  halloreundo: {}
  hallohtml: {}
  'hallo-image-insert-edit': {}

init = ->
  attach_editors()

  $('body').on "hallodeactivated", '.editable', ->
    $el = $(this)

    return if $el.data('original-content') == $el.html()

    data = {}
    method_data = {}
    method_data[$el.data('method')] = $el.html()
    data[ $el.data('model') ] = method_data
    data.in_place_update = true
    for property_name of $el.data()
      if typeof $el.data(property_name) == 'string' and property_name != 'method' and
       property_name != 'model' and property_name != 'updateUrl'
        data[property_name] = $el.data(property_name)

    $.ajax
      url: $el.data('update-url')
      type: 'PUT'
      data: data
      beforeSend: ->
        $el.addClass('hallo_updating')
      success: ->
        $el.data('original-content', $el.html())
        $el.removeClass('hallo_updating')
      error: (jqXHR, textStatus, errorThrown) ->
        $el.trigger('hallo:error', [jqXHR.responseText])


  $('body').on "hallodeactivated", '.form_editable', ->
    $el = $(this)
    hidden_textarea_name = "#{$el.data('model')}[#{$el.data('method')}]"
    $hidden_textarea = $el.next("textarea[name='#{hidden_textarea_name}']")
    $hidden_textarea.html $el.html()

attach_editors = ->
  context = this
  $('.editable, .form_editable').each ->
    $el = $(this)
    plugins = $el.data('editable-plugins') || default_plugins
    options = $el.data('editable-options') || default_options
    $.extend options, { plugins: plugins }
    $el.hallo options
    $el.data('original-content', $el.html())
    $el.click ->
      $(this).focus()     # required for firefox as otherwise when clicking on edit overlay element doesn't focus


@HalloRails = { default_options, default_plugins, init, attach_editors }




