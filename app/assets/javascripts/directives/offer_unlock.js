app.directive('unlockOffer', function(){
    return{
        restrict: 'E',
        replace: true,
        templateUrl: "templates/unlock_offer.html",
        link: function(scope){
            if(scope.poster.is_unlocked==true)
                scope.poster.unlock_text = 'Offer Unlocked';
            else
                scope.poster.unlock_text = 'Unlock the Offer';

        }
    }
})

