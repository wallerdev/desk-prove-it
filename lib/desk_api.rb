class DeskAPI
  SITE = "https://wallerdev.desk.com"
  
  def initialize
    @consumer = OAuth::Consumer.new(
      ENV['DESK_API_KEY'],
      ENV['DESK_API_SECRET'],
      :site => SITE,
      :scheme => :header
    )
    
    @access_token = OAuth::AccessToken.from_hash(
      @consumer, 
      :oauth_token => ENV['DESK_API_OAUTH_TOKEN'], 
      :oauth_token_secret => ENV['DESK_API_OAUTH_SECRET']
    )
  end

  # http://dev.desk.com/API/cases/#list
  def cases
    request_json('/api/v2/cases')
  end
    
  # http://dev.desk.com/API/labels/#list
  def labels
    request_json('/api/v2/labels')
  end
  
  # http://dev.desk.com/API/filters/#list
  def filters
    request_json('/api/v2/filters')
  end
  
  # http://dev.desk.com/API/filters/#show
  def filtered_cases(filter)
    request_json("#{filter['_links']['self']['href']}/cases")
  end

  # http://dev.desk.com/API/labels/#create
  # Note: it seems we can't create a label with a name that already exists, even if the label has been deleted?
  def create_label(name, description, types, color)    
    data = {
      'name' => name,
      'description' => description,
      'types' => types,
      'color' => color
    }

    result = @access_token.post(
      "#{SITE}/api/v2/labels", 
      data.to_json, 
      {'Accept'=>'application/json', 'Content-Type' => 'application/json'}
    )

    JSON.parse(result.body)
  end
  
  # http://dev.desk.com/API/labels/#delete
  def delete_label(url)
    @access_token.delete("#{SITE}#{url}")
  end
  
  # http://dev.desk.com/API/cases/#update
  def assign_label(desk_case, label)
    data = {
      "labels" => [label]
    }
    
    result = @access_token.put(
      "#{SITE}#{desk_case['_links']['self']['href']}",
      data.to_json,
      {'Accept'=>'application/json', 'Content-Type' => 'application/json'}
    )
    
    JSON.parse(result.body)
  end
  
  private
  
  # Submit a GET request to the Desk API using oauth, and return the resulting JSON.
  def request_json(url)
    JSON.parse(@access_token.get("#{SITE}#{url}").body)
  end
end