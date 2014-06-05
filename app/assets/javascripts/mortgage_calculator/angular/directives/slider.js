'use strict';

App.directive('uiSlider', function() {

  var linker = function(scope, element, attrs, ctrl) {

    //Dynamically grab input id passed in from view
    var input = angular.element('input.' + attrs.dynamicFor),
        expression = {},
        value,
        percentageForMin = attrs.percentageForMinimum || 50,
        percentageForMax = attrs.percentageForMaximum || 200;

    //Fire GA Events
    var gaRefinement = function(){
      window._gaq = window._gaq || [];

      var category = attrs.analyticsCategory,
          action = attrs.analyticsAction,
          label = attrs.analyticsLabel,
          refined = element.attr('refined');

      if (action == 'Refinement') {
        if (!(typeof refined !== 'undefined' && refined !== false)) {
          window._gaq.push(['_trackEvent',category,action,label]);
          element.attr('refined', '');
        }
      }
    };

    //Set initial slider state
    var options = {
      range: 'min',
      min: (percentageForMin / 100) * scope.value,
      max: (percentageForMax / 100) * scope.value,
      value: scope.value,
      slide: function (event, ui) {
          scope.$apply(function () {
              scope.value = ui.value;
              gaRefinement();
          });
      }
    };

    // Set attribute from element when they are available
    if (!angular.isUndefined(scope.min)) {
      expression['min'] = parseFloat(scope.min);
    }
    if (!angular.isUndefined(scope.max)) {
      expression['max'] = parseFloat(scope.max);
    }
    if (!angular.isUndefined(scope.step)) {
      expression['step'] = parseFloat(scope.step);
    }

    //Binding magic
    scope.$watch('value', function (newVal, oldVal) {
      if (!angular.isUndefined(newVal) && newVal != oldVal) {
        element.slider('value', newVal);
      }
    });

    scope.$watch('min', function (newVal, oldVal) {
      if (!angular.isUndefined(newVal) && newVal != oldVal) {
        element.slider('option', 'min', newVal);
      }
    });
    scope.$watch('max', function (newVal, oldVal) {
      if (!angular.isUndefined(newVal) && newVal != oldVal) {
        element.slider('option', 'max', newVal);
      }
    });
    scope.$watch('step', function (newVal, oldVal) {
      if (!angular.isUndefined(newVal) && newVal != oldVal) {
        element.slider('option', 'step', newVal);
      }
    });

    //Initial declaration of slider
    angular.extend(options, expression);
    element.slider(options);

    //Reconfigre slider when input blurs
    input.on('blur keyup', function() {
      value = parseInt($(this).val().replace(/[^\d|\-+|\.+]/g, '')) || 0;
      element.slider({
        min: (percentageForMin / 100) * value,
        max: (percentageForMax / 100) * value,
        value: value,
        step: (value / 100) * 1
      });
    });
  };

  var controller = function($scope) {};

  return {
    restrict: 'A',
    require: 'ngModel',
    controller: controller,
    link: linker,
    scope: {
      value: '=ngModel',
      min: '=min',
      max: '=max',
      step: '=step'
    }
  };
});
