require 'rubygems'
require 'mongo'

# If you don't select database, default value is 'admin'. So, you must select DB with connection.
@connection = Mongo::Client.new(['127.0.0.1:27017'], :database => 'tutorial')
@users = @connection['users']
