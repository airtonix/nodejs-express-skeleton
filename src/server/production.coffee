ServerBase = require './base'
path = require 'path'
serverRoot = path.resolve __dirname, '..', '..'

class ProductionServer extends ServerBase

	staticRoot: path.resolve serverRoot, 'build', 'assets'

	middleware: () ->
		super
		@app.use @express.compress()

	static: () ->
		super
		@app.use @express.favicon @staticRoot + 'img/favicon.png'


module.exports = ProductionServer