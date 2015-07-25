# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Posts
  constructor: (el) ->
    @el = el
    @el.find("#tag_cloud a").on 'click', @selectTag
    @setupDatatable()

  setupDatatable: ->    
    $.fn.getSelectedTags = @getSelectedTags
    table = @el.find("#posts").DataTable
      sDom: '<"search-box"r><"H"lf>t<"F"ip>'
      sPaginationType: "full_numbers"
      bJQueryUI: true
      bProcessing: true
      bServerSide: true
      iDisplayLength: -1
      aaSorting: []
      aoColumns: [{bSortable: false}, {bSortable: true}, {bSortable: true}, {bSortable: false}, {bSortable: false}, {bSortable: true}]
      pageLength: 10
      aLengthMenu: [[10, 25], [10, 25]]
      sAjaxSource: @el.find("#posts").data('source')
      fnServerData: (sSource, aoData, fnCallback, oSettings) ->
        data = aoData
        data.push { name: 'tag_list', value: @getSelectedTags() }
        oSettings.jqXHR = $.ajax(
          'dataType': 'json'
          'type': 'GET'
          'url': sSource
          'data': data
          'success': fnCallback)
                  
    table.on 'draw', ->
      body = $(table.table().body())
      body.unhighlight()
      if table.rows(filter: 'applied').data().length
        body.highlight table.search()
    @table = table

  selectTag: (e) =>
    e.preventDefault()
    target = $(e.currentTarget)
    if target.hasClass("active")
      target.removeClass("active")
    else
      target.addClass("active")
    @table.draw()

  getSelectedTags: =>
    _.map(@el.find("#tag_cloud a.active"), (a)-> $(a).data('name'))


window.Posts = Posts