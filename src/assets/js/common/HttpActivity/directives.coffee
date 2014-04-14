require [
    'angular'
    'lodash'
    ], (angular, _) ->

    angular.module 'app.common.httpActivity.directives', [
        'app.common.httpActivity.services'
    ]

        .directive 'httpActivityIndicator', [
            'HttpActivityService'
            (HttpActivityService)->
                restrict: "E"
                replace: true
                templateUrl: "/js/common/templates/http-activity-indicator.tpl.html"
                controller: ($scope, $element, $attrs, $transclude) ->
                    $scope.isResolved = HttpActivityService.hasPendingRequests
        ]