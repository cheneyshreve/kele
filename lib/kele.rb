require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
   include HTTParty
   include Roadmap

   def initialize(email, password)
     response = self.class.post(api_url("sessions"), body: {"email": email, "password": password })
     @auth_token = response["auth_token"]
     raise 'Invalid email or password' if response.code == 404 || @auth_token.nil?
   end

   def get_me
     response = self.class.get(api_url("users/me"), headers: {"authorization" => @auth_token })
     user_data = JSON.parse(response.body)
   end

   def get_mentor_availability(mentor_id)
     response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: {"authorization" => @auth_token })
     mentor_data = JSON.parse(response.body).to_a
     availablity = mentor_data.select do |hash|
       hash["booked"] != true
     end
   end

   def get_messages(page = nil)
     if page == nil
        response = self.class.get(api_url("message_threads"), headers: {"authorization" => @auth_token })
     else
       response = self.class.get(api_url("message_threads?page=#{page}"), headers: {"authorization" => @auth_token })
     end
      messages = JSON.parse(response.body)
   end

   def create_message(sender, recipient_id, token = nil, subject = nil, stripped_text)
     response = self.class.post(api_url("messages"), body: {
       "sender": sender,
       "recipient_id": recipient_id,
       "token": token,
       "subject": subject,
      "stripped-text": stripped_text },
       headers: { "authorization" => @auth_token }
     )
     puts response.success?
   end

   def create_submission(checkpoint_id, enrollment_id, assignment_branch, assignment_commit_link, comment)
     response = self.class.post(api_url("checkpoint_submissions"),
     body: {
       "checkpoint_id": checkpoint_id,
       "enrollment_id": enrollment_id,
       "assignment_branch": assignment_branch,
       "assignment_commit_link": assignment_commit_link,
       "comment": comment},
       headers: { "authorization" => @auth_token }
     )
     puts response.success?
   end

   private

   def api_url(endpoint)
     "https://www.bloc.io/api/v1/#{endpoint}"
   end

end
