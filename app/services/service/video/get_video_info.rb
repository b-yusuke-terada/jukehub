class ::Service::Video::GetVideoInfo
  attr_accessor :video_id

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @video_id = args[:video_id] if args.key?(:video_id)
  end

  def execute
    youtube = ::Gcp::Youtube.new
    video = youtube.get_video(@video_id)

    item = get_item(video)

    title = get_title(item)
    duration = get_duration(item)
    image_url = get_image_url(item)
    embeddable = get_embeddable(item)

    { title: title, duration: duration, image_url: image_url, embeddable: embeddable }
  end

  private
  def get_item(video)
    video["items"].first
  end

  def get_embeddable(item)
    item["status"]["embeddable"]
  end

  def get_title(item)
    item['snippet']['title']
    rescue => e
      'No Title'
  end

  def get_duration(item)
    ActiveSupport::Duration.parse(item['contentDetails']['duration']).to_i
    rescue => e
      0
  end

  def get_image_url(item)
    item['snippet']['thumbnails']['default']['url']
    rescue => e
      nil
  end
end
