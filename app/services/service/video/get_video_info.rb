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

    { title: title, duration: duration, image_url: image_url }
  end

  private
  def get_item(video)
    video["items"].first
  end

  def get_title(item)
    item['snippet']['title']
    rescue => e
      'No Title'
  end

  def get_duration(item)
    duration_text = item['contentDetails']['duration']
    durations = duration_text.gsub('PT', '').gsub('S', '').split(/M|H/).map{|m| m.to_i}
    if durations.length == 3
      durations[0] * 60 * 60 + durations[1] * 60 + durations[2]
    elsif durations.length == 2
      durations[0] * 60  + durations[1]
    elsif durations.length == 1
      durations[0]
    else
      0
    end

    rescue => e
      0
  end

  def get_image_url(item)
    item['snippet']['thumbnails']['default']['url']
    rescue => e
      nil
  end
end
