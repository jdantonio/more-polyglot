require 'sinatra'
require 'rest_client'
require 'active_support/core_ext/string'
require 'json'
require 'ostruct'

BASE_URL = 'http://www.reddit.com'

def popular_subreddits(limit = nil)
  count = limit.nil? ? '' : "?limit=#{limit.to_i}"
  response = RestClient.get(BASE_URL + "/subreddits/popular.json#{count}", {:accept => :json})
  JSON.parse(response)['data']['children'].collect do |sub|
    display_name = sub['data']['display_name']
    OpenStruct.new(display_name: display_name,
                   url: BASE_URL + sub['data']['url'],
                   hot: hot_topics(display_name, 4))
  end
end

def hot_topics(subreddit, limit = nil)
  count = limit.nil? ? '' : "?limit=#{limit.to_i}"
  response = RestClient.get(BASE_URL + "/r/#{subreddit}/hot.json#{count}", {:accept => :json})

  JSON.parse(response)['data']['children'].collect do |topic|
    OpenStruct.new(title: topic['data']['title'],
                   url: topic['data']['url'])
  end
end

get '/' do
  erb :index, locals: { subreddits: popular_subreddits(12) }
end
