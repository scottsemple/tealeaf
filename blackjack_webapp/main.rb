require 'rubygems'
require 'sinatra'

set :sessions, true

get '/' do
  '...some text in the browser.'
end

get '/template' do
 erb :mytemplate
end

get '/nested-template' do
  erb :"users/profile"
end

get '/not-here' do
  redirect '/'
end

