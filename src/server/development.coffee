ServerBase = require './base'

compile = require "compile-middleware"

fs = require 'fs'
path = require 'path'
sass = require "node-sass"
coffee = require "coffee-script"
jade = require 'jade'

assetRoot = path.resolve __dirname, '..', 'assets'
serverRoot = path.resolve __dirname, '..', '..'
vendorRoot = path.resolve serverRoot, 'bower_components'

sassOptions =
	include_paths: [
		vendorRoot
	]

assetMiddleware =
	js: compile
		src : assetRoot
		src_ext : '.coffee'
		headers :
			'content-type': 'application/javascript'
		filename : (request) ->
			request.path.replace ".js", ""
		render : (file, cb, deps) ->
			fs.readFile file, 'utf8', (err, content) ->
				if not err
					cb null, coffee.compile(content)
				cb err

	css: compile
		src : assetRoot
		src_ext : '.scss'
		headers :
			'content-type': 'text/css'
		filename : (request) ->
			request.path.replace ".css", ""
		render : (file, cb, deps) ->
			fs.readFile file, 'utf8', (err, content) ->
				if not err
					console.log file
					cb null, sass.renderSync(content, sassOptions)
				cb err

	html: compile
		src : assetRoot
		src_ext : '.jade'
		headers :
			'content-type': "text/html"
		filename : (request) ->
			source = request.path.replace ".html", ""
			if source.endsWith '/'
				source += "index"
			source
		render : (file, cb, deps) ->
			fs.readFile file, 'utf8', (err, content) ->
				if not err
					cb null, jade.compile(content, {})()
				cb err



class DevelopmentServer extends ServerBase
	secretKey: "SECRET"

	middleware : () ->
		@app.use @express.logger 'dev'
		@app.use assetMiddleware.js
		@app.use assetMiddleware.css
		@app.use assetMiddleware.html
		super

	done : () ->
		super
		console.log "Listening on #{@port}"
		console.log "Ctrl + C to close"

module.exports = DevelopmentServer
