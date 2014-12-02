#!/usr/bin/env ruby

require 'sinatra'
require 'rethinkdb'
require 'json'
require 'pp'

include RethinkDB::Shortcuts

set :port, 4567
set :environment, :production

RDB_HOST = ENV.fetch('RDB_HOST', 'localhost')
RDB_PORT = ENV.fetch('RDB_PORT', 28015)
DB_NAME  = ENV.fetch('DB_NAME', 'backbonetutorials')
DB_TABLE = 'users'

def safedb(verbose = false)
  yield if block_given?
rescue RethinkDB::RqlRuntimeError => ex
  puts ex.message if verbose
  false
end

def request_payload
  JSON.parse(@request_payload)
end

configure do
  begin
    r.connect(host: RDB_HOST, port: RDB_PORT).repl
    safedb { r.db_create(DB_NAME).run }
    safedb { r.db(DB_NAME).table_create(DB_TABLE).run }
  rescue Errno::ECONNREFUSED
    puts "Connection refused. Is RethinkDB running?"
  end
end

before do
  r.connect(host: RDB_HOST, port: RDB_PORT, db: DB_NAME).repl
  request.body.rewind
  @request_payload = request.body.read
end

get '/', provides: :html do
  #call '/index.html'
  #redirect to('/index.html')
  File.open('./index.html', 'r').read
end

# GET	/users	users#index	display a list of all users
# GET	/users/new	users#new	return an HTML form for creating a new user
# POST	/users	users#create	create a new user
# GET	/users/:id	users#show	display a specific user
# GET	/users/:id/edit	users#edit	return an HTML form for editing a user
# PATCH/PUT	/users/:id	users#update	update a specific user
# DELETE	/users/:id	users#destroy	delete a specific user

get '/users', provides: :json do
  content_type :json
end

get '/users/new', provides: :json do
  content_type :json
end

post '/users', provides: :json do
  content_type :json
  inserted = r.table(DB_TABLE).insert(request_payload).run
  user = request_payload.merge('id' => inserted['generated_keys'][0])
  p user
  user.to_json
end

get '/users/:id', provides: :json do
  content_type :json
  user = r.table(DB_TABLE).get(params[:id]).run
  p user
  user.to_json
end

get '/users/:id/edit', provides: :json do
  content_type :json
end

put '/users/:id', provides: :json do
  content_type :json
end

delete '/users/:id', provides: :json do
  content_type :json
end
