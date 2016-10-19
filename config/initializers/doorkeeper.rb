Doorkeeper.configure do
  orm :active_record
  access_token_expires_in nil
  reuse_access_token

  resource_owner_authenticator do
    currenet_user || warden.authenticate!(scope: :user)
  end
end
