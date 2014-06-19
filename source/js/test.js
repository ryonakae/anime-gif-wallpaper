jQuery(function(){
  // 画像の遅延ロード
  // loaderを追加
  jQuery.fn.addLoader = function() {
    this.parent().addClass("imgLoading");
  };
  // 遅延ロード
  jQuery.fn.lazyLoad = function() {
    this.each(function(){
      var _imgData = jQuery(this).attr("data-original");

      // data-original属性がある場合
      if ( _imgData !== "undefined" && _imgData !== false ) {
        jQuery(this).attr("src", _imgData);
      }

      // ロード後
      jQuery(this)
        .on("load", function(){
          jQuery(this).transition({ "opacity" : 1 }, 800, function(){
            // jQuery(this).removeAttr("style");
            jQuery(this).parent().removeClass("imgLoading");
          });
        })
        .attr( "src", jQuery(this).attr("src") + "?" + (new Date().getTime()) )
      ;
    });

    return this;
  };
  function common_LazyLoad() {
    var img = $("#content").find("img").not(".notLazy");
    img.addLoader();
    setTimeout(function(){
      img.lazyLoad();
    }, 600);
  }

  jQuery(window).on("load", function(){
    common_LazyLoad();
  });
});