ProductionServer = require './production'
path = require 'path'


class TestServer extends ProductionServer

	middleware: () ->
		super
		@app.use @express.logger 'dev'

	done: () ->
		super
		console.log "Listening on #{@port}"
		console.log "Ctrl + C to close"


module.exports = TestServer