require 'spec_helper'
require 'desk_api'

describe DeskAPI do
  it "should return a list of cases" do
    api = DeskAPI.new
    expect(api.cases).to have_key('total_entries')
  end
end