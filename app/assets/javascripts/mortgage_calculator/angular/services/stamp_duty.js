'use strict';

App.factory('StampDuty', function() {
    var SECOND_HOME_TAX_THRESHOLD = 40000,
        SECOND_HOME_TAX_RATE = 3,
        FIRST_TIME_BUYER_THRESHOLD = 500000;

    var stampDuty = {
      propertyPrice : 0,
      buyerType: '',
      rates_no_FTB: [
        {
          threshold: 125000,
          rate: 0
        }, {
          threshold: 250000,
          rate: 2
        }, {
          threshold: 925000,
          rate: 5
        }, {
          threshold: 1500000,
          rate: 10
        }, {
          threshold: 100000000,
          rate: 12
        }
      ],
      rates_FTB: [
        {
          threshold: 300000,
          rate: 0
        }, {
          threshold: 500000,
          rate: 5
        }
      ],

      cost: function() {
        var totalTax = 0,
            remaining = this.propertyPrice,
            rates,
            $conditionalMessage = $('.stamp-duty__FTB_conditional');

        if (this.buyerType === 'isFTB') {
          if (this.propertyPrice <= FIRST_TIME_BUYER_THRESHOLD) {
            rates = this.rates_FTB;
            $conditionalMessage.removeClass('is-active');
          } else {
            rates = this.rates_no_FTB;
            $conditionalMessage.addClass('is-active');
          }
        } else {
          rates = this.rates_no_FTB;
          $conditionalMessage.removeClass('is-active');
        }

        for (var i = 0; i < rates.length; i++) {
          var rateObj = rates[i],
              previousRateObj = i > 0 ? rates[i - 1] : null,
              bandwidth = 0,
              remainingTaxable = 0,
              bandTaxable = 0;

          if (!previousRateObj) {
            bandwidth = rateObj.threshold;
          } else {
            bandwidth = rateObj.threshold - previousRateObj.threshold;
          }

          remainingTaxable = Math.min(rateObj.threshold, remaining);
          bandTaxable = Math.min(bandwidth, remainingTaxable);
          totalTax += (bandTaxable * rateObj.rate / 100);
          remaining -= bandwidth;

          if (remaining < 0) {
            break;
          }
        }

        if (this.buyerType === 'isSecondHome' && this.propertyPrice >= SECOND_HOME_TAX_THRESHOLD) {
          totalTax += this.propertyPrice * (SECOND_HOME_TAX_RATE / 100);
        }

        return totalTax;
      },

      totalPurchase : function() {
        return (this.propertyPrice + this.cost());
      },

      percentageTax : function() {
        return ((this.cost() / this.propertyPrice) * 100) || 0;
      }
    };

    return stampDuty;
  });
