require 'spec_helper'
require 'desk_api'

describe DeskAPI, '#cases' do
  it "should return a list of cases" do
    api = DeskAPI.new
    expect(api.cases['_links']['self']['href']).to match('cases')
  end
end

describe DeskAPI, '#labels' do
  it "should return a list of labels" do
    api = DeskAPI.new
    expect(api.labels['_links']['self']['href']).to match('labels')
  end
end