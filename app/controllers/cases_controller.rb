require 'desk_api'

class CasesController < ApplicationController
  def index
    api = DeskAPI.new
    @cases = api.cases['_embedded']['entries']
  end
end
