require [
		'angular'
		'lodash'
		'angular-animate'
		'common/HttpActivity/directives'
		'common/HttpActivity/services'
	], (angular, _) ->

		angular.module 'app.common.httpActivity', [
			'ngAnimate'
			'app.common.httpActivity.directives'
			'app.common.httpActivity.services'
		]

