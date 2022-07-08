require 'sinatra'
require 'sinatra/reloader'

get '/' do 
  @title = 'TOP'
  erb :index
end

get '/new' do 
  @title = 'new content'
  @content = '登録する'
  erb :new
end

post '/new' do
  @name = params['name']
  @content = params['content']
  redirect to("/show?name=#{@name}&content=#{@content}")
end

get '/show' do 
  @title = 'show content'
  @name = params['name']
  @content = params['content']
  erb :show
end

