#connect our whole program so files can talk to one another
#require all gems

require 'pry'
require 'net/http'
require 'json'
require 'colorize'
require 'colorized_string'

require_relative './lib/api'
require_relative './lib/cli'
require_relative './lib/park'
require_relative './lib/state'