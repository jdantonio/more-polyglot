(function() {
  var app = angular.module('store-products', []);

  app.directive('productPrice', function() {
    return {
      restrict: 'A',
      templateUrl: 'templates/product-price.html'
    };
  });

  app.directive('productPanels', function() {
    return {
      restrict: 'E',
      templateUrl: 'templates/product-panels.html',
      controllerAs: 'panel',
      controller: function() {
        this.tab = 1;
        this.selectTab = function(setTab) {
          this.tab = setTab;
        };
        this.isSelected = function(checkTab) {
          return this.tab === checkTab;
        };
      }
    };
  });

  app.directive('productGallery', function() {
    return {
      restrict: 'E',
      templateUrl: 'templates/product-gallery.html',
      controllerAs: 'gallery',
      controller: function() {
        this.current = 0;
        this.setCurrent = function(value) {
          this.current = value || 0;
        };
      }
    };
  });

  app.directive('productReview', function() {
    return {
      restrict: 'E',
      templateUrl: 'templates/product-review.html'
    };
  });

  app.directive('productReviewForm', function() {
    return {
      restrict: 'E',
      templateUrl: 'templates/product-review-form.html'
    };
  });
})();
