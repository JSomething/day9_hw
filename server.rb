require 'sinatra'
require 'data_mapper'
require 'shotgun'

DataMapper.setup(
	:default,
	'mysql://root@localhost/blog_index'
	)

class Entry
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :subject, String
	property :content, String
	property :created_at, String
	property :updated_at, String
end

# instruction to auto-update db with new entries
DataMapper.finalize.auto_upgrade!

get '/' do
	@entry = Entry.all
	erb :index
end

# new
get '/new' do
	erb :new_entry_form
end

# create
post '/' do
	@entry = Entry.new
	@entry.title = params[:title]
	@entry.subject = params[:subject]
	@entry.content = params[:content]
	@entry.save
	redirect to '/'
end

# display
get '/entry/:id' do
	@entry = Entry.get params[:id]
	erb :display_entry
end

# edit
get '/:id' do
	@entry = Entry.get params[:id]
	erb :edit_entry
end

put '/:id' do
	@entry = Entry.get params[:id]
	@entry.title = params[:title]
	@entry.subject = params[:subject]
	@entry.content = params[:content]
	@entry.save
	redirect to '/'
end

get '/:id/delete' do
	@entry = Entry.get params[:id]
	erb :delete_entry
end

delete '/:id' do
	@entry = Entry.get params[:id]
	@entry.destroy
	redirect '/'
end


