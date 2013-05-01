/*jslint unparam: true, browser: true, indent: 2 */

;(function ($, window, document, undefined) {
  'use strict';

  var $flipThis = $('.flip-this');
  if ($flipThis.length > 0) {
    $flipThis.on('click', function (e) {
      e.preventDefault();
      $flipThis.closest('.flip>div').toggleClass('active');
    });
  }

}(Foundation.zj, this, this.document));