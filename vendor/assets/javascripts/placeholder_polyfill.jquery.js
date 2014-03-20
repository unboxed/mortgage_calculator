/** * Copyright (c) 2008 Tom Deater (http://www.tomdeater.com) 
 * Licensed under the MIT License: 
 * http://www.opensource.org/licenses/mit-license.php 
 * Updated by Dirk Ginader: 2013-03-31 
 */ 
jQuery.onFontResize=function(e){return e(document).ready(function(){var t=e("<iframe />").attr("id","frame-onFontResize"+Date.parse(new Date)).css({width:"100em",height:"10px",position:"absolute",borderWidth:0,top:"-5000px",left:"-5000px"}).appendTo("body"),n=/(msie) ([\w.]+)/.exec(navigator.userAgent.toLowerCase())||[],i=n[1]||"";if("msie"===i)t.bind("resize",function(){e.onFontResize.trigger(t[0].offsetWidth/100)});else{var o=t[0].contentWindow||t[0].contentDocument||t[0].document;o=o.document||o,o.open(),o.write('<div id="em" style="width:100em;height:10px;"></div>'),o.write('<script>window.onload = function(){var em = document.getElementById("em");window.onresize = function(){if(parent.jQuery.onFontResize){parent.jQuery.onFontResize.trigger(em.offsetWidth / 100);}}};</script>'),o.close()}}),{trigger:function(t){e(document).trigger("fontresize",[t])}}}(jQuery);
/** 
 * Html5 Placeholder Polyfill - v2.0.9 - 2014-01-21 
 * web: http://blog.ginader.de/dev/jquery/HTML5-placeholder-polyfill/ 
 * issues: https://github.com/ginader/HTML5-placeholder-polyfill/issues 
 * Copyright (c) 2014 Dirk Ginader; Licensed MIT, GPL 
 */
(function(e){function o(e,o){""===e.val()?e.data("placeholder").removeClass(o.hideClass):e.data("placeholder").addClass(o.hideClass)}function t(e,o){e.data("placeholder").addClass(o.hideClass)}function i(e,o){var t=o.is("textarea"),i=parseFloat(o.css("padding-top")),a=parseFloat(o.css("padding-left")),n=o.offset();i&&(n.top+=i),a&&(n.left+=a),e.css({width:o.innerWidth()-(t?20:4),height:o.innerHeight()-6,lineHeight:o.css("line-height"),whiteSpace:t?"normal":"nowrap",overflow:"hidden"}).offset(n)}function a(e,o){var i=e.val();(function a(){r=requestAnimationFrame(a),e.val()!==i&&(t(e,o),s(),n(e,o))})()}function n(e,t){(function i(){r=requestAnimationFrame(i),o(e,t)})()}function s(){window.cancelAnimationFrame&&cancelAnimationFrame(r)}function l(e){d&&window.console&&window.console.log&&window.console.log(e)}var r,d=!1;e.fn.placeHolder=function(n){l("init placeHolder");var r=this,d=e(this).length;return this.options=e.extend({className:"placeholder",visibleToScreenreaders:!0,visibleToScreenreadersHideClass:"placeholder-hide-except-screenreader",visibleToNoneHideClass:"placeholder-hide",hideOnFocus:!1,removeLabelClass:"visuallyhidden",hiddenOverrideClass:"visuallyhidden-with-placeholder",forceHiddenOverride:!0,forceApply:!1,autoInit:!0},n),this.options.hideClass=this.options.visibleToScreenreaders?this.options.visibleToScreenreadersHideClass:this.options.visibleToNoneHideClass,e(this).each(function(n){function c(){!r.options.hideOnFocus&&window.requestAnimationFrame?a(v,r.options):t(v,r.options)}var h,p,u,f,v=e(this),m=v.attr("placeholder"),w=v.attr("id");return(""===m||void 0===m)&&(m=v[0].attributes.placeholder.value),h=v.closest("label"),v.removeAttr("placeholder"),h.length||w?(h=h.length?h:e('label[for="'+w+'"]').first(),h.length?(f=e(h).find(".placeholder"),f.length?(i(f,v),f.text(m),v):(h.hasClass(r.options.removeLabelClass)&&h.removeClass(r.options.removeLabelClass).addClass(r.options.hiddenOverrideClass),p=e("<span>").addClass(r.options.className).text(m).appendTo(h),u=p.width()>v.width(),u&&p.attr("title",m),i(p,v),v.data("placeholder",p),p.data("input",v),p.click(function(){e(this).data("input").focus()}),v.focusin(c),v.focusout(function(){o(e(this),r.options),r.options.hideOnFocus||s()}),o(v,r.options),e(document).bind("fontresize resize",function(){i(p,v)}),e.event.special.resize?e("textarea").bind("resize",function(o){e(this).is(":visible")&&i(p,v),o.stopPropagation(),o.preventDefault()}):e("textarea").css("resize","none"),n>=d-1&&e.attrHooks!==void 0&&(e.attrHooks.placeholder={get:function(o){return"input"===o.nodeName.toLowerCase()||"textarea"===o.nodeName.toLowerCase()?e(o).data("placeholder")?e(e(o).data("placeholder")).text():e(o)[0].placeholder:void 0},set:function(o,t){return e(e(o).data("placeholder")).text(t)}}),v.is(":focus")&&c(),void 0)):(l("the input element with the placeholder needs a label!"),void 0)):(l("the input element with the placeholder needs an id!"),void 0)})},e(function(){var o=window.placeHolderConfig||{};return o.autoInit===!1?(l("placeholder:abort because autoInit is off"),void 0):("placeholder"in e("<input>")[0]||"placeHolder"in e("<input>")[0])&&!o.forceApply?(l("placeholder:abort because browser has native support"),void 0):(e("input[placeholder], textarea[placeholder]").placeHolder(o),void 0)})})(jQuery);