require 'sinatra'
require 'sinatra/reloader'

def parse_memo_detail id
  f = File.new("./public/#{id}/name.txt")
  name = f.gets
  f = File.new("./public/#{id}/content.txt")
  content = ""
  f.read(nil,content)
  {:id=>id, :name=>name, :content=>content}
end

def parse_memo_directories
  Dir.open('./public/').children.reject{|dir_name| dir_name.include? "del" }
end

def create_memo_directory
  id = Dir.open('./public/').children.size + 1
  Dir.mkdir("./public/#{id}", 0777)
  id 
end

def write_memo id, name, content
  IO.write("./public/#{id}/name.txt", "#{name}")
  IO.write("./public/#{id}/content.txt", "#{content}")
end

def sanitizing_text text
  text.gsub(/&|<|>|"|'/, '&'=>'&amp;', "<"=>'&lt;', ">"=>'&gt;', "\""=>'&quot;', "'"=>'&#39;')
end

def delete_memo id
  File.rename("./public/#{id}", "./public/#{id}.del")
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
  id = create_memo_directory
  write_memo(id, params['name'], params['content'])
  redirect to("/show/#{id}")
end

put '/new/:id' do
  write_memo(params['id'], params['name'], params['content'])
  redirect to("/show/#{params['id']}")
end

get '/show/:id' do 
  @title = 'show content'
  @memo_info = parse_memo_detail(params['id'])
  erb :show
end

put '/:id/edit' do 
  @title = 'edit'
  @memo_info = parse_memo_detail(params['id'])
  erb :edit
end

delete '/:id/delete' do 
  @title = 'delete'
  @memo_info = parse_memo_detail(params['id'])
  delete_memo(params['id'])
  erb :delete
end
