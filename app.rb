require 'sinatra'
require 'pony'

configure do
  Pony.options = {
    :headers => { 'Content-Type' => 'text/html' },
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
    :body => nl2br(params[:body])
  )
  @sent = true
  erb :index
end

def nl2br(string)
  string.gsub("\n\r","<br>").gsub("\r", "").gsub("\n", "<br />")
end