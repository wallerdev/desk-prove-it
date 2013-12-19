require 'desk_api'

class CasesController < ApplicationController
  def index
    api = DeskAPI.new
    @first_filter = api.filters['_embedded']['entries'][0]
    @cases = api.filtered_cases(@first_filter)['_embedded']['entries']
    
  end
  
  def update
    api = DeskAPI.new
    @first_filter = api.filters['_embedded']['entries'][0]
    @cases = api.filtered_cases(@first_filter)['_embedded']['entries']
    desk_case = @cases[0]
    
    api.assign_label(desk_case, params[:label])
    
    flash[:success] = 'Assigned label to first case'
    redirect_to cases_path
  end
end
