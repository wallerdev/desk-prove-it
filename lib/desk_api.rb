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
  
  def cases
    request_json('/api/v2/cases')
  end
  
  def labels
    request_json('/api/v2/labels')
  end
  
  private
  
  def request_json(url)
    JSON.parse(@access_token.get("#{SITE}#{url}").body)
  end
end