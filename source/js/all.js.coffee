#= require core/jquery.min.js
#= require core/jquery.easing.min.js
#= require core/jquery.transit.min.js
#= require_tree .


$ ->
  ###
  Set Function
  ###
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
    img.lazyLoad()


  # article height
  articleHeightResize = ->
    article = $(".article")
    imageHeight = $(".article-image").height()

    if $(window).height() > imageHeight
      article.css "height" : $(window).height()
    else
      article.css "height" : imageHeight + 100


  # img resize
  $.fn.imgResize = (options) ->
    options = $.extend
      area : $(@).parent()
      type : "both" # horizontal, vertical, both
    , options

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
      img.css
        "width" : setWidth
        "height" : setHeight
        "left" : imgLeft
    else if options.type == "vertical"
      img.css
        "width" : setWidth
        "height" : setHeight
        "top" : imgTop
    else
      img.css
        "width" : setWidth
        "height" : setHeight
        "top" : imgTop
        "left" : imgLeft

  articleImgResizeInitial = ->
    $(".l-main .article").each ->
      $(@).find(".article-image .image-gif img")
        .imgResize()
        .transition "opacity" : 1, 600, ->
          $(@).closest(".article-image").find(".image-flame")
          .addClass("is-animate")

  articleImgResize = ->
    $(".l-main .article").each ->
      $(@).find(".article-image .image-gif img")
        .imgResize()
        .transition "opacity" : 1, 600


  # backtop
  backTop = ->
    $(".footer-backtop").click ->
      $("html, body").stop().animate scrollTop : 0, 1000, "easeInOutCubic"


  articleAutoPager = ->
    $(".pager-next a").on "click", (e) ->
      e.preventDefault()

      # loader fadein
      $(".l-loader").fadeIn(400)

      # ajax get
      $.ajax({
        type: "GET",
        url: $(@).attr("href") + "#articles",
        dataType: "html",
        success: (out) ->
          result = $(out).find("#articles").find(".article").unwrap()
          nextLink = $(out).find(".pager-next a").attr('href')
          # console.log getAbsolutePath(nextLink)

          result.css "opacity" : 0
          result.each ->
            $(@).find(".image-gif-inner img").lazyLoad()

          $("#articles").append(result).imagesLoaded ->
            articleHeightResize()
            articleImgResize()
            setTimeout ->
              result.transition "opacity" : 1, 800
              $(".l-loader").fadeOut(400)
            , 1000

          if nextLink != undefined
            $(".pager-next a").attr("href", getAbsolutePath(nextLink))
          else
            $(".pager-next a").hide()
      })

      # convert absolute path
      getAbsolutePath = (path) ->
        $("<a>").attr("href", path).get(0).href


  # about popup
  aboutPopUp = ->
    $(".l-header .navigation-about").on "click", ->
      $(".l-about").addClass("is-shown")
      $(".logo").addClass("is-hidden")

    $(".l-about .about-overlay, .l-about .about-close").on "click", ->
      $(".l-about").removeClass("is-shown")
      $(".logo").removeClass("is-hidden")


  ###
  Do Function
  ###
  # ready
  # articleImgLazyLoad()
  articleHeightResize()
  backTop()
  aboutPopUp()
  articleAutoPager()

  # load
  $(window).on "load", ->
    articleImgResizeInitial()

  # resize
  $(window).on "resize", ->
    articleHeightResize()
    articleImgResize()