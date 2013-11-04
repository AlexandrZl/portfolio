require 'sinatra/base'
EMAIL_REGEX =  /[\w]+\@[\w]+\.[\w]/

module Sinatra
  def validate
    @errors << 'Check entered data email'  unless params[:email].match EMAIL_REGEX
    @errors << 'Check entered data message' if params[:message].empty?
    @errors << 'Check entered data name' if params[:name].empty?
  end
helpers Sinatra
end



 