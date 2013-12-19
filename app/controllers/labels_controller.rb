require 'desk_api'

class LabelsController < ApplicationController
  def index
    api = DeskAPI.new
    @labels = api.labels['_embedded']['entries']
  end
end
