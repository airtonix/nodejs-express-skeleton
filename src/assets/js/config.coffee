require [
	'angular',
	'lodash',
	'restangular'
	], (angular, _) ->

		angular.module 'app.config', [
			'restangular'
		]
			.config [
				'$locationProvider'
				'$sceDelegateProvider'
				'RestangularProvider'
				($locationProvider, $sceDelegateProvider, RestangularProvider) ->
					# ugly hack to take care of the placeholder
					# video and audio in our apiary api
					$sceDelegateProvider.resourceUrlWhitelist [
						'self',
						'http://vjs.zencdn.net/**'
					]

					$locationProvider.hashPrefix("#!")
					RestangularProvider.setBaseUrl 'http://muvli.apiary.io/api/v1/'
					RestangularProvider.setDefaultHttpFields 'cache', true
					RestangularProvider.setRestangularFields
						id: "guid"

					@
			]

			.run [
				'$rootScope'
				'$routeSegment'
				($rootScope, $routeSegment) ->
					$rootScope.routeSegment = $routeSegment
			]