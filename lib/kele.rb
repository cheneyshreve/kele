require 'httparty'
require 'json'

class Kele
   include HTTParty
   base_uri "https://www.bloc.io/api/v1/"

   def initialize(email, password)
     response = self.class.post(api_url("sessions"), body: {"email": email, "password": password })
     @auth_token = response["auth_token"]
     raise 'Invalid email or password' if response.code == 404 || @auth_token.nil?
   end

   def get_me
     response = self.class.get(api_url("users/me"), headers: {"authorization" => @auth_token })
     @user_data = JSON.parse(response.body)   
   end

   private
   def api_url(endpoint)
     "https://www.bloc.io/api/v1/#{endpoint}"
   end

end
