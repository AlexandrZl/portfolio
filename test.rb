require 'rubygems'
require 'sinatra'
require 'activerecord'

enable :sessions

get '/foo' do
  session[:message] = 'Hello World!'
  redirect to('/bar')
end

get '/bar' do
  session[:message]   # => 'Hello World!'
end