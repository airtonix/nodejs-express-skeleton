require [
    'angular'
    'angular-route'
    'angular-route-segment'
    ], (angular) ->

    angular.module 'app.routes', [
            'ngRoute',
            'route-segment',
            'view-segment'
        ]

        .config [
            '$routeSegmentProvider',
            '$routeProvider',
            '$locationProvider',
            ($routeSegmentProvider, $routeProvider, $locationProvider) ->
                $routeSegmentProvider.options.autoLoadTemplates = true
                $routeSegmentProvider.options.strictMode = true

                $locationProvider
                  .html5Mode false
                  .hashPrefix '!'

        ]
