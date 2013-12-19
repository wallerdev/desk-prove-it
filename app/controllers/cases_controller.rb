require 'desk_api'

class CasesController < ApplicationController
  def index
    api = DeskAPI.new
    @first_filter = api.filters['_embedded']['entries'][0]
    @cases = api.filtered_cases(@first_filter)['_embedded']['entries']
    
  end
end
