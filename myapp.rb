require 'sinatra'
require 'sinatra/reloader'

get '/' do 
  @title = 'main'
  @content = 'main contnt'
  erb :index
end

get '/new' do 
  @title = 'new'
  @content = 'new contnt'
  erb :new
end

get '/about' do 
  @title = 'about'
  @content = 'about contnt'
  @email = 'mail@k.com'
  erb :about
end

