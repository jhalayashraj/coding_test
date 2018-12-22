class UserSerializer < ActiveModel::Serializer
	## Attributes ##
  attributes :id, :email, :username, :authentication_token

  ## Instance Methods ##
  def authentication_token
    object.authentication_tokens
      .create(auth_token: AuthenticationToken.generate_unique_token)
      .auth_token
  end
end
