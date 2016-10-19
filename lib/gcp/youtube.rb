require 'google/api_client'

class Gcp::Youtube
  attr_accessor :client

  YOUTUBE_SCOPE = 'https://www.googleapis.com/auth/youtube'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def initialize
    @client = Google::APIClient.new(
      :application_name => 'JUKEHUB',
      :application_version => '1.0.0'
    )
    key = ::Google::APIClient::KeyUtils.load_from_pkcs12('./keys/jukehub_dev.p12', 'notasecret')
    scope = [ YOUTUBE_SCOPE ]
    @client.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      audience: 'https://accounts.google.com/o/oauth2/token',
      scope: scope,
      issuer: ENV["GCP_USER"],
      signing_key: key
    )
    @client.authorization.fetch_access_token!
    @api = @client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
  end

  def get_video(video_id)
    res = @client.execute({
      api_method: @api.videos.list,
      parameters: {
        part: 'id,snippet,contentDetails',
        id: video_id,
      }
    })
    JSON.parse(res.body)
  end

  def search(query)
    res = @client.execute({
      api_method: @api.search.list,
      parameters: {
        part: 'snippet',
        q: query,
      }
    })
    JSON.parse(res.body)
  end
end
