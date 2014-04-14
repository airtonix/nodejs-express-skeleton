require [
	'angular',
	'lodash'
	], (angular, _) ->

		angular.module 'app.common.httpActivity.services', []

			.factory 'HttpActivityService', [
				'$http'
				'$rootScope'
				($http, $rootScope) ->
					service =
						hasPendingRequests: ->
							$http.pendingRequests.length > 0

					$rootScope.$on '$routeChangeStart', (Event, current, previous) ->
						# console.log '$routeChangeStart', current
						if current.$$route and current.$$route.resolve
							# // Show a loading message until promises are not resolved
							$rootScope.loadingView = true

					$rootScope.$on '$routeChangeSuccess', (current, next) ->
						# console.log '$routeChangeSuccess', current
						@

					$rootScope.$on 'routeSegmentChange', (index, segment) ->
						# console.log '$routeSegmentChange', segment
						@

					service
			]
