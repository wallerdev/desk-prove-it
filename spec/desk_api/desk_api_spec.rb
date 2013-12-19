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

describe DeskAPI, '#create_label' do
  it "should create a label with the specified name" do
    api = DeskAPI.new
    
    # Use a random name for labels since they can't seem to be recreated even when deleted.
    label_name = SecureRandom.hex
    
    result = api.create_label(label_name, 'test description', ['case'], 'blue')
    
    expect(result['name']).to eq(label_name)
    expect(result['description']).to eq('test description')
    expect(result['types'][0]).to eq('case')
    expect(result['types'].size).to eq(1)
    expect(result['color']).to eq('blue')
    
        
    api.delete_label(result['_links']['self']['href'])
  end
end

describe DeskAPI, '#delete_label' do
  it "should delete a label with a specified url" do
    api = DeskAPI.new
    
    # Use a random name for labels since they can't seem to be recreated even when deleted.
    label_name = SecureRandom.hex
    
    result = api.create_label(label_name, 'test description', ['case'], 'blue')        
    api.delete_label(result['_links']['self']['href'])
    
    deleted_label = api.labels['_embedded']['entries'].find { |label| label['name'] == label_name}
    
    expect(deleted_label).to be_nil
  end
end

describe DeskAPI, '#filters' do
  it "should return a list of filters" do
    api = DeskAPI.new
    expect(api.filters['_links']['self']['href']).to match('filters')
  end
end

describe DeskAPI, '#filtered_cases' do
  it "should return a list of filtered cases" do
    api = DeskAPI.new
    filter = api.filters['_embedded']['entries'][0]
    
    expect(api.filtered_cases(filter)['_links']['self']['href']).to match(/filters\/\d+\/cases/)
  end
end
