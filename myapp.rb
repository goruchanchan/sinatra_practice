require 'sinatra'
require 'sinatra/reloader'

def design_memo  name, content
  "#{name} \n#{content}"
end

def open_memo_detail memo_id
  f = File.new("./public/#{memo_id}.txt")
  name = f.gets
  content = ""
  f.read(nil,content)
  {:id=>memo_id, :name=>name, :content=>content}
end

def get_memo_num
  Dir.open('./public/').children.size
end

def create_memo name, content
  next_memo_id = get_memo_num + 1
  File.open("./public/#{next_memo_id}.txt", mode = "w"){|f|
    f.write( design_memo(name, content) )
  }
  next_memo_id
end

get '/' do 
  @title = 'TOP'
  erb :index
end

put '/edit' do 
  @title = 'edit'
  @memo_info = open_memo_detail(params['id'])
  erb :edit
end

get '/new' do 
  @title = 'new content'
  erb :new
end

post '/new' do
  memo_id = create_memo(params['name'], params['content'])
  redirect to("/show?id=#{memo_id}")
end

get '/show' do 
  @title = 'show content'
  @memo_info = open_memo_detail(params['id'])
  erb :show
end

delete '/' do
  
end
