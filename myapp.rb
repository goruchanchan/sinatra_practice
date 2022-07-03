require 'sinatra'
require 'sinatra/reloader'

get '/' do 
  @title = 'TOP'
  @content = 'メモアプリ'
  erb :index
end

get '/new' do 
  @title = 'new'
  @content = 'new contnt'
  erb :new
end

post '/new' do
  redirect to('/about')
end

get '/about' do 
  @title = 'about'
  @content = 'about contnt'
  @email = 'mail@k.com'
  erb :about
end

