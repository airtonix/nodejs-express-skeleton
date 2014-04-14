#!/usr/bin/env coffee

mode = process.env.NODE_ENV || 'development'
ServerClass = require "./#{mode}.coffee"

new ServerClass