vendor = ""

require.config
	paths:
		'lodash': "/vendor/lodash/dist/lodash.underscore.min"
		'angular': "/vendor/angular/angular"
		'angular-touch': "/vendor/angular-touch/angular-touch.min"
		'angular-route': "/vendor/angular-route/angular-route.min"
		'angular-animate': "/vendor/angular-animate/angular-animate.min"
		'angular-sanitize': "/vendor/angular-sanitize/angular-sanitize.min"
		'angular-route-segment': "/vendor/angular-route-segment/build/angular-route-segment"
		'moment': "/vendor/momentjs/moment"

		'restangular': "/vendor/restangular/dist/restangular.min"
		'videogular': "/vendor/videogular/videogular.min"
		'videogular-poster': "/vendor/videogular-poster/poster.min"
		'videogular-buffering': "/vendor/videogular-buffering/buffering.min"
		'videogular-controls': "/vendor/videogular-controls/controls.min"
		'videogular-overlay-play': "/vendor/videogular-overlay-play/overlay-play.min"

		'app-common': "common/main"
		'app-songs': "songs/main"
		'app-videos': "videos/main"
		'app-muvli': "muvli/main"
		'app-users': "users/main"
		'app-activity': "activity/main"
		'app-vendor': "vendor/main"

	shim :
		'lodash': exports: '_'
		'angular':  exports: 'angular'
		'angular-route':  deps: ['angular']
		'angular-touch':  deps: ['angular']
		'angular-animate':  deps: ['angular']
		'angular-sanitize':  deps: ['angular']
		'angular-route-segment':  deps: ['angular', 'angular-route']

		'restangular': deps: ['angular']
		'videogular': deps: ['angular', 'angular-sanitize']
		'videogular-poster': deps: ['videogular']
		'videogular-controls': deps: ['videogular']
		'videogular-buffering': deps: ['videogular']
		'videogular-overlay-play': deps: ['videogular']

		'app':  deps: [
			'lodash'
			'moment'
			'angular'
	        'angular-animate'
			'angular-route-segment'
			'restangular'
			'videogular-poster'
			'videogular-controls'
			'videogular-buffering'
			'videogular-overlay-play'
			'config'
			'routes'
			'app-vendor'
			'app-common'
			'app-songs'
			'app-videos'
			'app-muvli'
			'app-users'
			'app-activity'
		]

	urlArgs: "bust=" +  (new Date()).getTime()
	deps: [ 'app' ]
