require 'sinatra'
require 'pony'

configure do
  Pony.options = {
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
end

before do
  puts '[Params]'
  p params
end

get '/' do
  erb :index
end

post '/' do
  Pony.mail(
    :to => params[:to],
    :from => params[:from],
    :subject => params[:subject],
    :body => params[:body]
  )
  @msg = "Email sent!"
  erb :index
end