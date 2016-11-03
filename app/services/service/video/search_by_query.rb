require 'gcp/youtube'

class ::Service::Video::SearchByQuery
  attr_accessor :query

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @query = args[:query]
  end

  def execute
    youtube = ::Gcp::Youtube.new
    res = youtube.search(query)
    res["items"].map{|m|
      {
        video_id: m["id"]["videoId"],
        title: m["snippet"]["title"],
        image_url: m["snippet"]["thumbnails"]["default"]["url"]
      }
    }
  end
end
