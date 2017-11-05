require 'json'

class MessagesController < ApplicationController
  def show
    @message = Message.find(params[:id])
  end

  def new
    
  end

  def create
    if request.content_type =~ /xml/
      message_hash = Hash.from_xml(request.body.read)

      params[:message] = {"content" => message_hash["message"]}

      @message = Message.create(message_params)
      
      url = {"url" => messages_url + "/" + @message.id.to_s}

      #url = '<?xml version = "1.0" encoding = "UTF-8" standalone ="yes"?>' + 
       #     "<url>" + 
        #      messages_url + '/' + @message.id.to_s + 
         #   "</url>"

      render :xml => url.to_xml(:root => :address, :skip_types => true)
    else
      respond_to do |format|
          format.json {
            params[:message] = {"content" => params[:message]}

            @message = Message.create(message_params)

            url = {"url" => messages_url + "/" + @message.id.to_s}

            render :json => url.to_json
          }

          format.html {
            @message = Message.create(message_params)

            render :get_url
          }
      end
    end
  end
 
  def get_url
    
  end

private
  def message_params
    params.require(:message).permit(:content)
  end
end
