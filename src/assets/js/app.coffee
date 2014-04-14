require [
        'angular'

        'config'

        'app-vendor'
        'app-common'
        'app-songs'
        'app-videos'
        'app-muvli'
        'app-users'
        'app-activity'
        'templates',
        'routes'
    ], (angular) ->

        angular.module "app", [
            'vendor'
            'ngAnimate'
            'app.config'
            'app.common'
            'app.users'
            'app.songs'
            'app.videos'
            'app.muvli'
            'app.activity'

            'app.routes'
        ]

        angular.bootstrap document, ['app']
