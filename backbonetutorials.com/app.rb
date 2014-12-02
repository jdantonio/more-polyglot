#!/usr/bin/env ruby

require 'sinatra'
require 'json'
require 'pp'

set :port, 8080
set :environment, :production

USERS_TABLE = []

def request_payload
  JSON.parse(@request_payload)
end

before do
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

#get '/users', provides: :json do
  #content_type :json
#end

#get '/users/new', provides: :json do
  #content_type :json
#end

post '/users', provides: :json do
  content_type :json
  user_id = USERS_TABLE.length
  user = request_payload.merge('id' => user_id)
  USERS_TABLE << request_payload
  p user
  user.to_json
end

get '/users/:id', provides: :json do
  content_type :json
  user_id = params[:id].to_i
  user = USERS_TABLE[user_id]
  p user
  user.to_json
end

#get '/users/:id/edit', provides: :json do
  #content_type :json
#end

put '/users/:id', provides: :json do
  content_type :json
  user_id = params[:id].to_i
  user = request_payload.merge('id' => user_id)
  USERS_TABLE[user_id] = request_payload
  p user
  user.to_json
end

delete '/users/:id', provides: :json do
  content_type :json
  user_id = params[:id].to_i
  USERS_TABLE[user_id] = nil
  p "Deleted user #{user_id}"
  {'id' => user_id, 'error' => nil}.to_json
end
