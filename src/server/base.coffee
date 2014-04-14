require 'string.prototype.endswith'

_ = require 'lodash'
util = require 'util'
http = require 'http'
path = require 'path'
fs = require 'fs'
express = require "express"
uuid = require 'node-uuid'

app = express()
server = http.createServer(app)

serverRoot = path.resolve __dirname, "..", ".."

class BaseServer
	mode: process.env
	port: process.env.PORT || 9000
	app: app
	server: server
	express: express

	secretKey: uuid.v4()

	viewsEngine: 'jade'

	serverRoot: serverRoot
	featureRoot: path.resolve __dirname, 'features'
	viewsRoot: path.resolve serverRoot, "src", "server", "views"
	staticRoot: path.resolve serverRoot, "src", "assets"
	vendorRoot: path.resolve serverRoot, "bower_components"

	config: () ->
		console.log " > config..."
		console.log "   views: #{@viewsRoot}"
		@app.set 'views', @viewsRoot
		@app.set 'view engine', @viewsEngine

	middleware: () ->
		console.log " > middleware..."
		@app.use @express.bodyParser()
		@app.use @express.methodOverride()
		@app.use @express.cookieParser(@secretKey)
		@app.use @express.session()

	static: () ->
		console.log " > static..."
		console.log "   root: #{@staticRoot}"
		@app.use "/", @express.static @staticRoot
		console.log "   vendor: #{@vendorRoot}"
		@app.use "/vendor", @express.static @vendorRoot

	features: () ->
		featureRoot = @featureRoot
		console.log " > features..."
		console.log "   root: #{featureRoot}"
		tree = fs.readdirSync featureRoot
		_.forEach tree, (file) ->
			root = path.join featureRoot, file
			try
				route = require root
				route.controller app
				console.log "   > #{file}: #{root}"

			catch error
				console.error " > Error", error

	done: () ->
		console.log "Starting #{@constructor.name}"

	constructor: (@options) ->
		_.extend @, @options

		@config()
		@middleware()
		@features()
		@static()
		@app.listen @port
		@done()

module.exports = BaseServer