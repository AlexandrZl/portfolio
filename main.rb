require 'sinatra'
require 'pony'




get "/" do
  @active1='class="active"'
  @title='Main'
  erb :main               
end
get "/biography" do
  @active2='class="active"'
  @title='Bio'
  erb :biography          
end
get "/hobby" do
  @active3='class="active"'
   @title='hobby'
  erb :hobby             
end
get "/about" do
  @active4='class="active"'
   @title='about'
  erb :about              
end
get "/contact" do
  @active5='class="active"'
   @title='contact'
  erb :contact              
end
post '/contact' do
  
  options = {
    :to => params[:email],
    :from => 'put your email',
    :subject => params[:name],
    :html_body => params[:message],
    :via => :smtp,
    :via_options => {
      :address => 'smtp.gmail.com',
      :port => 587,
      :enable_starttls_auto => true,
      :user_name => 'put your email',
      :password => 'put your password',
      :authentication => :plain,
      :domain => 'localhost'
    }
  }
  Pony.mail(options)
end