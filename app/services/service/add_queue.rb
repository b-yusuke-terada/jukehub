class ::Service::AddQueue
  attr_accessor :video_id
  attr_accessor :video_info
  attr_accessor :room
  attr_accessor :user_id

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @room = args[:room]
    @video_id = args[:video_id]
    @user_id = args[:user_id]
  end

  def execute
    video = ::Video.find_or_create_by({
      provider: ::Video::PROVIDER_YOUTUBE,
      provider_video_id: @video_id
    })
    @video_info = ::Service::Video::GetVideoInfo.new({video_id: @video_id}).execute
    video.update_attributes({
      title: @video_info[:title],
      duration: @video_info[:duration],
      image_url: @video_info[:image_url]
    })

    raise StandardError.new('この動画は再生できません') unless @video_info[:embeddable]

    @room.add_queue(@user_id, video)
  end
end
