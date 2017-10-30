require 'json'
require 'xml'

class MessagesController < ApplicationController
  def show
    @message = Message.find(params[:id])
  end

  def new
    
  end

  def create
    #json_file = File.read(ARGV[0])
    #data_hash = JSON.parse(json_file)

    @message = Message.new(message_params)
   
    @message.save

    render :get_url
    #redirect_to action get_url or smth
  end
 
  def get_url
    
  end

private
  def message_params
    params.require(:message).permit(:text)
  end
end
