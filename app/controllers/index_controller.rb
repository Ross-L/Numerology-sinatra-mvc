require 'sinatra'

get '/' do
    erb :form
end

post '/' do
    birthdate = params[:birthdate]
    if Person.valid_birthdate(birthdate) 
        setup_index_view
        redirect "/message/#{@birth_path_number}"
    else
        @error = 'You should enter a valid birthdate in the form of mmddyyyy.'
        erb :form
    end
end

get '/newpage/' do
    @message = all_messages
    erb :newpage
end

get '/message/:birth_path_number' do
    @birth_path_number = params[:birth_path_number].to_i
    @message = Person.birth_path_message(@birth_path_number)    
    erb :index
end

=begin
get '/:birthdate' do
    setup_index_view
end
=end

def all_messages
    message = Array.new
    for i in 1..9
    message.push(birth_path_message(i))
    end
    return message
end

def setup_index_view
    birthdate = params[:birthdate].gsub("-","")
    @birth_path_number = Person.birth_path_number(birthdate)
    @message = Person.birth_path_message(@birth_path_number)
    erb :index
end