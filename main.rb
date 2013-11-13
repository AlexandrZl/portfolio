require 'sinatra'
require 'rubygems'
require 'pony'
require "sinatra/activerecord"
require_relative './helpers/validate'

helpers Valid
 
set :database, "sqlite3:///user.db"
 
class User < ActiveRecord::Base
end


configure do
  enable :sessions
  set :session_secret, 'secret'
end

post '/login' do
  session[:foo] = params[:username], params[:password], params[:email]
  @user = User.new(:name => params[:username], :password => params[:password], :email => params[:email])
  if @user.save
    redirect "/"
  else
    redirect '/hobby'
  end
end

post '/sign' do
  if params[:nameuser] == User.find(:all)
    session[:foo]=params[:name], params[:password]
    redirect "/"
  else 
    redirect "/notaunt"
  end
  end

get '/notaunt' do
  erb :error
end


post '/logout' do
  session.clear
  redirect '/'
end 

get "/" do
  @title='Main'
  erb :main      
end

get "/biography" do
  @title='Bio'
  erb :biography          
end

get "/hobby" do
   @title='hobby'
  erb :hobby             
end

get "/about" do
   @title='about'
  erb :about              
end

before '/contact' do
  @errors = []
end

get "/contact" do
   @title='contact'
  erb :contact              
end

get "/success" do
  erb :success              
end

get "/reg" do
  @title='Sign up'
  erb :register      
end

post '/contact' do
  validate            #method from Helpers with module Valid
  unless @errors.any?
  options = {
    :to => params[:email],
    :subject => "Message by #{params[:name]}",
    :html_body => params[:message],
    :via => :smtp,
    :via_options => {
      :address => 'smtp.gmail.com',
      :port => 587,
      :enable_starttls_auto => true,
      :user_name => 'puts your email',
      :password => 'password',
      :authentication => :plain,
      :domain => 'localhost'
    }
  }
  Pony.mail(options)
  redirect '/success'
  else
    erb :contact
  end
end