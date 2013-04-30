/*jslint unparam: true, browser: true, indent: 2 */

;(function ($, window, document, undefined) {
  'use strict';

  var $openNav = $('.flip-nav #navLink');
  if ($openNav.length > 0) {
    $openNav.on('click', function (e) {
      e.preventDefault();
      $('.flip-nav>div').addClass('active');
    });
  }

  var $closeNav = $('.flip-nav #closeNavLink');
  if ($closeNav.length > 0) {
    $closeNav.on('click', function (e) {
      e.preventDefault();
      $('.flip-nav>div').removeClass('active');
    });
  }

}(Foundation.zj, this, this.document));