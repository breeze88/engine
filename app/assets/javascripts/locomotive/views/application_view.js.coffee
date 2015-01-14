class Locomotive.Views.ApplicationView extends Backbone.View

  el: 'body'

  events:
    'click .navbar .navbar-toggle': 'slide_sidebar'

  initialize: ->
    @header_view  = new Locomotive.Views.Shared.HeaderView()
    @sidebar_view = new Locomotive.Views.Shared.SidebarView()
    @drawer_view  = new Locomotive.Views.Shared.DrawerView()

  render: ->
    @render_flash_messages(@options.flash)

    @sidebar_view.render()
    @drawer_view.render()

    @set_max_height()

    @automatic_max_height()

    # render page view
    if @options.view?
      @view = new @options.view(@options.view_data || {})
      @view.render()

    return @

  slide_sidebar: (event) ->
    $('body').toggleClass('slide-top-sidebar')

  render_flash_messages: (messages) ->
    _.each messages, (couple) ->
      $.growl couple[1], { type: couple[0] }

  automatic_max_height: ->
    $(window).on 'resize', => @set_max_height()

  set_max_height: ->
    max_height  = $(window).height()
    height      = max_height - @header_view.height()

    @$('> .wrapper').height(height)

  # center_ui_dialog: ->
  #   $(window).resize ->
  #     $('.ui-dialog-content:visible').dialog('option', 'position', 'center')

  # add_submenu_behaviours: ->
  #   $('#submenu ul li.hoverable').each ->
  #     timer = null
  #     link  = $(@)
  #     (popup = link.find('.popup')).removeClass('popup').addClass('submenu-popup'
  #     ).bind('show', ->
  #       link.find('a').addClass('hover') & popup.css(
  #         top:  link.offset().top + link.height() - 2
  #         left: link.offset().left - parseInt(popup.css('padding-left'))
  #       ).show()
  #     ).bind('hide', ->
  #       link.find('a').removeClass('hover') & $(@).hide()
  #     ).bind('mouseleave', -> popup.trigger('hide')
  #     ).bind 'mouseenter', -> clearTimeout(timer)

  #     $(document.body).append(popup)

  #     link.hover(
  #       -> popup.trigger('show')
  #       -> timer = window.setTimeout (-> popup.trigger('hide')), 30
  #     )

  #   css = $('#submenu > ul').attr('class')
  #   $("#submenu > ul > li.#{css}").addClass('on') if css != ''

  # enable_sites_picker: ->
  #   link    = @$('#sites-picker-link')
  #   picker  = @$('#sites-picker')

  #   return if picker.size() == 0

  #   left = link.position().left + link.parent().position().left - (picker.width() - link.width())
  #   picker.css('left', left)

  #   link.bind 'click', (event) ->
  #     event.stopPropagation() & event.preventDefault()
  #     picker.toggle()

  # enable_content_locale_picker: ->
  #   link    = @$('#content-locale-picker-link')
  #   picker  = @$('#content-locale-picker')

  #   return if picker.size() == 0

  #   link.bind 'click', (event) ->
  #     event.stopPropagation() & event.preventDefault()
  #     picker.toggle()

  #   picker.find('li').bind 'click', (event) ->
  #     locale = $(@).data('locale')
  #     window.addParameterToURL 'content_locale', locale

  # set_locale_for_tinymce_widgets: ->
  #   # tinyMCE likes only lowercase locales
  #   tinymce_locale = window.locale.toLowerCase()

  #   # pt-BR does not exist, pt does though
  #   tinymce_locale = 'pt' if tinymce_locale == 'pt-br'

  #   # set the default tinyMCE language
  #   window.Locomotive.tinyMCE.defaultSettings.language  = tinymce_locale
  #   window.Locomotive.tinyMCE.minimalSettings.language  = tinymce_locale
  #   window.Locomotive.tinyMCE.popupSettings.language    = tinymce_locale

  unique_dialog_zindex: ->
    # returns the number of jQuery UI modals created in order to set a valid zIndex for each of them.
    # Each modal window should have a different zIndex, otherwise there will be conflicts between them.
    window.Locomotive.jQueryModals ||= 0

    # 998 + window.Locomotive.jQueryModals++
    300000 + window.Locomotive.jQueryModals++
