require 'sinatra'
require 'sinatra/reloader'

$memos_path = "./public/memos/"

def parse_memo_detail id
  f = File.new("#{$memos_path}#{id}/name.txt")
  name = f.gets
  f = File.new("#{$memos_path}#{id}/content.txt")
  content = ""
  f.read(nil,content)
  {:id=>id, :name=>name, :content=>content}
end

def parse_memo_directories
  Dir.open("#{$memos_path}").children.reject{|dir_name| dir_name.include? "del" }
end

def create_memo_directory
  id = Dir.open("#{$memos_path}").children.size + 1
  Dir.mkdir("#{$memos_path}#{id}", 0777)
  id 
end

def write_memo id, name, content
  IO.write("#{$memos_path}#{id}/name.txt", "#{name}")
  IO.write("#{$memos_path}#{id}/content.txt", "#{content}")
end

def sanitizing_text text
  text.gsub(/&|<|>|"|'/, '&'=>'&amp;', "<"=>'&lt;', ">"=>'&gt;', "\""=>'&quot;', "'"=>'&#39;')
end

def delete_memo id
  File.rename("#{$memos_path}#{id}", "#{$memos_path}#{id}.del")
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
