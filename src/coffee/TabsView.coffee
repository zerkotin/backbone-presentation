
exorts.TabsView = class TabsView extends Backbone.View

  tabs: null
  currentTab: null

  events:
    'click .tab-title': '_tabClicked'

  initialize: (options) ->
    {@tabs} = options
    @render()

  render: ->
    $tabsElement = $(template())
    @$el.append($tabsElement)

    $titlesElement = $tabsElement.find('.tabs-titles')

    @tabs.foreach (tab, i) ->
      $titlesElement.append(titleTemplate(tab.name))

      if(i is 0) # default is first
        @_selectTab(tab)

  _tabClicked: (event) ->
    $item = $(event.currentTarget)
    tabName = $item.data('name')

    #search in tabs a tab with that name

  _selectTab: (tab) ->
    $contentContainer = @$el.find('.content-container')

    @currentTab?.remove()

    $contentElement = $(contentTemplate())
    $contentContainer.append $contentElement

    viewOptions = $.extend(true, {el: $contentElement}, tab.viewOptions)

    @currentTab = new tab.viewConstructor(viewOptions)

    #mark title with active
    @$el.find('.tab-title').removeClass('active')
    @$el.find(".tab-title[data-name='#{tab.name}']").addClass('active')



template = ->
  """
  <div class="tabs-titles"></div>
  <div class="content-container"></div>
  """

contentTemplate = ->
  """
  <div class="tab-content"></div>
  """

titleTemplate = (title) ->
  """
  <span class="tab-title" data-name="#{title}">#{title}</span>
  """
