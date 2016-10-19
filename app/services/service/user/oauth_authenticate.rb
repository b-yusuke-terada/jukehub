class Service::User::OauthAuthenticate
  attr_accessor :auth

  def initialize(**args)
    prepare(args)
  end

  def prepare(**args)
    @auth = args[:auth] if args.key?(:auth)
  end

  # もうちょっときれいに書きたい
  def execute(**args)
    attribute = eval("#{@auth["provider"]}")
    account = Account.find_or_create_by!({
      provider: attribute[:provider],
      uid: attribute[:uid]
    })
    account.update_attributes(attribute)

    if account.user
      return account.user
    else
      user = User.create!({email: '', password: Devise.friendly_token[0, 20]})
      user.accounts << account
      return account.user
    end
  end

  private
  def twitter
    {
      provider: @auth["provider"],
      uid: @auth["uid"],
      name: @auth["info"]["name"],
      email: '',
      image_url: auth["info"]["image"],
    }
  end
end
