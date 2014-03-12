'use strict';

App.controller('CalculatorCtrl', ['$scope', 'Affordability', 'StampDuty', function ($scope, Affordability, StampDuty) {

    //Affordability Calculations
    $scope.affordability = Affordability;
    $scope.affordability.selectedOption = $scope.affordability.numberOfPeople[0];

    $scope.normalizeValues = function() {
      if ($scope.affordability.selectedOption === 1 || $scope.affordability.selectedOption === 2) {
        $scope.affordability.earnings.person2.annual = 0;
        $scope.affordability.earnings.person2.extra = 0;
      }
    };


    //Stamp Duty Calculations
    $scope.stampDuty = StampDuty;


  }]);
