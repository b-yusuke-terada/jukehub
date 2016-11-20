class Service::User::ConnectSocialAccount
  attr_accessor :user
  attr_accessor :auth

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @user = args[:user]
    @auth = args[:auth]
  end

  # もうちょっときれいに書きたい
  def execute(**args)
    attribute = eval("#{@auth["provider"]}")
    # user が居た場合
    if @user
      account = @user.accounts.find_or_create_by!({
        provider: attribute[:provider],
        uid: attribute[:uid]
      })
      account.update_attributes(attribute)
      return account.user
    else
      account = Account.find_by!({
        provider: attribute[:provider],
        uid: attribute[:uid]
      })
      return account.user
    end
  end

  private
  def twitter
    {
      provider: @auth["provider"],
      uid: @auth["uid"],
      name: @auth["info"]["nickname"],
      screen_name: @auth["info"]["name"],
      email: @auth["info"]["email"],
      image_url: @auth["info"]["image"],
    }
  end

  def google
    {
      provider: @auth["provider"],
      uid: @auth["uid"],
      name: @auth["info"]["name"],
      screen_name: nil,
      email: @auth["info"]["email"],
      image_url: @auth["info"]["image"]
    }
  end
end
