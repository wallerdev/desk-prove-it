require 'desk_api'

class LabelsController < ApplicationController
  def index
    api = DeskAPI.new
    @labels = api.labels['_embedded']['entries']
  end
  
  def new
    
  end
  
  def create
    api = DeskAPI.new
    
    response = api.create_label(params[:name], params[:description], ['case'], 'blue')
    
    if response['errors']
      flash.now[:danger] = "Unable to create label: #{response['message']}"
      render 'new'
    else
      flash[:success] = 'Label succesfully created'
      redirect_to labels_path
    end
  end
end
