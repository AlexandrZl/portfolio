require 'sinatra'
require 'pony'





get "/" do
  erb :main                
end
get "/biography" do
  erb :biography          
end
get "/about" do
  erb :about              
end
get "/hobby" do
  erb :hobby             
end
get "/contact" do
  erb :contact              
end

post '/contact' do
  options = {
    :to => params[:email],
    :from => 'geedisgood72@gmail.com',
    :subject => 'Test',
    :body => 'Test Text',
    :html_body => params[:text],
    :via => :smtp,
    :via_options => {
      :address => 'smtp.gmail.com',
      :port => 587,
      :enable_starttls_auto => true,
      :user_name => 'geedisgood72@gmail.com',
      :password => 'greedisgood',
      :authentication => :plain,
      :domain => 'localhost'
    }
  }
  Pony.mail(options)
  redirect '/contact'
  end

 

 