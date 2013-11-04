require 'sinatra'
require 'rubygems'
require 'pony'
require_relative './helpers/validate'

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

get "/contact" do
   @title='contact'
  erb :contact              
end
get "/success" do
  erb :success              
end

before '/contact' do
  @errors = []
end

set :username,'user'
set :token,'sfdgfdg44425'
set :password,'resu'

helpers do
  def admin? ; request.cookies[settings.username] == settings.token ; end
  def protected! ; halt [ 401, 'Not Authorized' ] unless admin? ; end
end

post '/login' do
  if params['username']==settings.username&&params['password']==settings.password
      response.set_cookie(settings.username,settings.token) 
      redirect '/'
    else
      "Username or Password incorrect"
    end
end

post('/logout'){ response.set_cookie(settings.username, false); redirect "/" }


post '/contact' do
  validate
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