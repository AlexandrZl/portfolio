require 'sinatra'
require 'pony'
EMAIL_REGEX =  /[\w]+\@[\w]+\.[\w]/

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

before '/contact' do
  @errors = []
end

post '/contact' do
  errors << 'Check entered data email'  unless params[:email].match EMAIL_REGEX
  @errors << 'Check entered data message' if params[:message].empty?
  @errors << 'Check entered data name' if params[:name].empty?
  unless @errors.any?
  options = {
    :to => params[:email],
    :from => 'puts email',
    :subject => "Message by #{params[:name]}",
    :html_body => params[:message],
    :via => :smtp,
    :via_options => {
      :address => 'smtp.gmail.com',
      :port => 587,
      :enable_starttls_auto => true,
      :user_name => 'puts email',
      :password => '[uts password]',
      :authentication => :plain,
      :domain => 'localhost'
    }
  }
  Pony.mail(options)
  redirect '/hobby'
  else
    erb :contact
  end

end