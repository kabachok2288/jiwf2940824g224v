require 'sinatra'
require 'pony'

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