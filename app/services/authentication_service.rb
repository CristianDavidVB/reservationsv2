class AuthenticationService
  SECRET = Rails.application.secrets.secret_key_base

  def self.encode_token(payload, exp = 1.day.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode_token(token)
    decoded_token = JWT.decode(token, SECRET)[0]

    User.find(decoded_token["user_id"])
  rescue
    nil
  end
end