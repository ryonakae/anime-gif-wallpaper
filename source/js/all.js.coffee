#= require core/jquery.min.js
#= require core/jquery.easing.min.js
#= require core/jquery.transit.min.js
#= require_tree .


$ ->
  # addLoader
  $.fn.addLoader = ->
    @.parent().addClass("imgLoading")

  # lazyLoad
  $.fn.lazyLoad = ->
    @.each ->
      imgData = $(@).attr("data-original")

      # data-original is true
      if  imgData != "undefined" && imgData != false
        $(@).attr("src", imgData)

      # after load
      $(@)
      .on "load", ->
        $(@).transition "opacity" : 1 , 800, ->
          $(@).parent().removeClass("imgLoading")
      .attr( "src", $(@).attr("src") + "?" + (new Date().getTime()) )

  articleImgLazyLoad = ->
    img = $(".article").find("img")
    img.addLoader()
    setTimeout ->
      img.lazyLoad()
    , 100


  # article height
  articleHeightResize = ->
    aspectWidth = 9
    aspectHeight = 16
    article = $(".article")
    articleWidth = article.width()
    articleHeight = articleWidth * (16 / 9)

    article.css({ "height" : articleHeight })


  # img resize
  $.fn.imgResize = (options) ->
    options = $.extend({
      area : $(@).parent(),
      type : "both" # horizontal, vertical, both
    }, options)

    areaWidth = $(options.area).width()
    areaHeight = $(options.area).height()

    img = $(this)
    imgWidth = img.width()
    imgHeight = img.height()
    scaleWidth = areaWidth / imgWidth
    scaleHeight = areaHeight / imgHeight
    fixScale = Math.max(scaleWidth, scaleHeight)
    setWidth = Math.floor(imgWidth * fixScale)
    setHeight = Math.floor(imgHeight * fixScale)
    imgTop = Math.floor((setHeight - areaHeight) / -2)
    imgLeft = Math.floor((setWidth - areaWidth) / -2)

    if options.type == "horizontal"
      img.css({
        "width" : setWidth,
        "height" : setHeight,
        "left" : imgLeft
      })
    else if options.type == "vertical"
      img.css({
        "width" : setWidth,
        "height" : setHeight,
        "top" : imgTop
      })
    else
      img.css({
        "width" : setWidth,
        "height" : setHeight,
        "top" : imgTop,
        "left" : imgLeft
      })

  articleImgResize = ->
    $(".l-main .article").each ->
      $(@).find("img").imgResize()


  # article image show
  articleImgShow = ->


  # load
  $(window).on "load", ->
    # articleImgLazyLoad()
    articleHeightResize()
    articleImgResize()
    # articleImgShow()

  # resize
  $(window).on "resize", ->
    articleHeightResize()
    articleImgResize()