class DeskAPI
  SITE = "https://wallerdev.desk.com"
  
  def cases
    consumer = OAuth::Consumer.new(
      ENV['DESK_API_KEY'],
      ENV['DESK_API_SECRET'],
      :site => SITE,
      :scheme => :header
    )

    access_token = OAuth::AccessToken.from_hash(
      consumer, 
      :oauth_token => ENV['DESK_API_OAUTH_TOKEN'], 
      :oauth_token_secret => ENV['DESK_API_OAUTH_SECRET']
    )

    JSON.parse(access_token.get("#{SITE}/api/v2/cases").body)
  end
  
  def labels
    consumer = OAuth::Consumer.new(
      ENV['DESK_API_KEY'],
      ENV['DESK_API_SECRET'],
      :site => SITE,
      :scheme => :header
    )

    access_token = OAuth::AccessToken.from_hash(
      consumer, 
      :oauth_token => ENV['DESK_API_OAUTH_TOKEN'], 
      :oauth_token_secret => ENV['DESK_API_OAUTH_SECRET']
    )

    JSON.parse(access_token.get("#{SITE}/api/v2/labels").body)
  end
end