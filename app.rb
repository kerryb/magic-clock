# Lovingly ripped off from http://code.google.com/p/google-api-ruby-client/wiki/OAuth2

require "google/api_client"
require "sinatra" 
require "mongo"
require "uri"

uri = URI.parse(ENV["MONGOHQ_URL"])
conn = Mongo::Connection.from_uri(ENV["MONGOHQ_URL"])
db = conn.db(uri.path.gsub(/^\//, ""))

def save_token token
  db.tokens.save(
    refresh_token: token.refresh_token,
    access_token: token.access_token,
    expires_in: token.expires_in,
    issued_at: Time.at(token.issued_at)
  )["id"]
end

def load_token id
  db.tokens.find id
end

use Rack::Session::Pool, :expire_after => 86400 # 1 day

before do
  @client = Google::APIClient.new
  @client.authorization.client_id = "362523634792.apps.googleusercontent.com"
  @client.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
  @client.authorization.scope = "https://www.googleapis.com/auth/latitude.current.best https://www.googleapis.com/auth/userinfo.profile"
  @client.authorization.redirect_uri = to("/oauth2callback")
  @client.authorization.code = params[:code] if params[:code]
  token_id = session[:token_id]
  if token_id
    @client.authorization.update_token! load_token(token_id)
  end
  if @client.authorization.refresh_token && @client.authorization.expired?
    @client.authorization.fetch_access_token!
  end
  @latitude = @client.discovered_api("latitude")
  unless @client.authorization.access_token || request.path_info =~ /^\/oauth2/
    redirect to("/oauth2authorize")
  end
end

get "/oauth2authorize" do
  redirect @client.authorization.authorization_uri.to_s, 303
end

get "/oauth2callback" do
  @client.authorization.fetch_access_token!
  session[:token_id] = save_token @client.authorization
  
  redirect to("/")
end

get "/" do
  return load_token(session[:token_id]).inspect
  result = @client.execute(
    @latitude.something
  )
  status, _, _ = result.response
  [status, {"Content-Type" => "application/json"}, JSON.generate(result.data)]
end
