require 'sinatra'
require 'sinatra/reloader'

def design_memo  name, content
  "#{name} #{content}"
end

def create_memo name, content
  file_num = Dir.open('./public/').children.size
  File.open("./public/#{file_num + 1}.txt", mode = "w"){|f|
    f.write( design_memo(name, content) )
  }
end

get '/' do 
  @title = 'TOP'
  erb :index
end

get '/new' do 
  @title = 'new content'
  erb :new
end

post '/new' do
  create_memo(params['name'], params['content'])
  redirect to("/show?name=#{params['name']}&content=#{params['content']}")
end

get '/show' do 
  @title = 'show content'
  @name = params['name']
  @content = params['content']
  erb :show
end

