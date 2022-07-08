require 'sinatra'
require 'sinatra/reloader'

get '/' do 
  @title = 'TOP'
  erb :index
end

get '/new' do 
  @title = 'new content'
  erb :new
end

post '/new' do
  @name = params['name']
  @content = params['content']

  File.open("./public/#{@name}.txt", mode = "w"){|f|
    f.write(@content)
  }

  redirect to("/show?name=#{@name}&content=#{@content}")
end

get '/show' do 
  @title = 'show content'
  @name = params['name']
  @content = params['content']
  erb :show
end

