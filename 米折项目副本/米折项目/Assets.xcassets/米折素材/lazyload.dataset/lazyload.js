<script type="text/javascript">
(function(win, lib) {
 var defaultConfig = {
 placeholder: 'http://s0.husor.cn/image/app/mizhe_loading.jpg',
 threshold: 50,
 originImgAttr: 'data-src',
 markAttr: 'use-lazyload'
 };
 
 var slice = Array.prototype.slice;
 
 var extend = function(tar) {
 var i, j, args = slice.call(arguments, 1);
 for (i in args) {
 for (j in args[i]) {
 tar[j] = args[i][j];
 }
 }
 return tar;
 };
 
 var getStyle = function(elem, name) {
 if (elem.style[name]) return elem.style[name];
 
 else if (document.defaultView && document.defaultView.getComputedStyle) {
 name = name.replace(/(A-Z)/g, '-$1');
 name = name.toLowerCase();
 
 var s = document.defaultView.getComputedStyle(elem, null);
 return s && s.getPropertyValue(name);
 } else if (elem.currentStyle) return elem.currentStyle[name];
 
 else return null;
 };
 
 var getHeight = function(elem) {
 return parseInt(getStyle(elem, 'height'));
 };
 
 var winHeight = function() {
 var de = document.documentElement;
 return window.innerHeight ||
 (de && de.clientHeight) ||
 document.body.clientHeight;
 };
 
 var offsetY = function(elem) {
 return elem.offsetParent ?
 elem.offsetTop + offsetY(elem.offsetParent) :
 elem.offsetTop;
 };
 
 lib.lazyload = function(config) {
 var cf = extend({}, defaultConfig, config),
 len,
 img,
 scrollTop = 0,
 screenHeight = winHeight(),
 loadedImg = [],
 watingImg = [];
 
 var scrollLoadImg = function() {
 
 scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
 len = watingImg.length;
 
 for (; len--;) {
 
 item = watingImg[len];
 showTop = offsetY(item.img) - cf.threshold;
 showBottom = showTop + 2 * cf.threshold + getHeight(item.img);
 if (showTop <= scrollTop + screenHeight && scrollTop <= showBottom) {
 if (item.oriImg) {
 item.img.setAttribute('src', item.oriImg);
 item.img.removeAttribute('height');
 }
 watingImg.splice(len, 1);
 loadedImg.push(img);
 }
 }
 
 };
 
 var getLazyImg = function() {
 var aImgs = document.querySelectorAll('[data-src]');
 
 slice.call(aImgs).forEach(function(img, index) {
                           
                           if (cf.placeholder !== null) {
                           img.src = cf.placeholder;
                           }
                           
                           var info = {
                           img: img,
                           oriImg: img.getAttribute(cf.originImgAttr)
                           };
                           
                           var offsetTop = offsetY(img);
                           
                           
                           info.showTop = offsetTop - cf.threshold;
                           info.showBottom = offsetTop + getHeight(img) + cf.threshold;
                           watingImg.push(info);
                           img.removeAttribute(cf.markAttr);
                           img.removeAttribute(cf.originImgAttr);
                           });
 
 };
 
 getLazyImg();
 
 setTimeout(function() {
            scrollLoadImg();
            });
 
 window.addEventListener('scroll', scrollLoadImg, false);
 
 return {
 
 getLazyImg: getLazyImg,
 scrollLoadImg: scrollLoadImg,
 loadedImg: loadedImg,
 watingImg: watingImg
 
 };
 };
 
 })(window, window.lib || (window.lib = {}));

window.lib.lazyload({
                    threshold: 1280,
                    markAttr: 'data-src',
                    originImgAttr: 'data-src'
                    });
</script>