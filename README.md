# The Kele app is a Ruby Gem for accessing Bloc's API.

## Installation
Add this line to your application's Gemfile:
```
gem 'kele'
```
Execute:
$ bundle

Or install using:
$ gem install kele

## Usage
Use the client with your Bloc credentials:
```
$ irb
require './lib/kele'
kele_client = Kele.new("yourBlocEmail@example.com", "yourBlocPassword")
```
Retrieve the current user data as a JSON blob (parsed as a Ruby hash):
```
$ irb
kele_client.get_me
```

Retrive a list of your mentor's availability, stored in a Ruby array:
```ruby
$ irb
kele_client.get_mentor_availability(mentor_id)
```
Retrieve your student roadmap or checkpoint information:
```ruby
$ irb
kele_client.get_roadmap(roadmap_id)
kele_client.get_checkpoint(checkpoint_id)
```

Retrieve all pages of your email messages from the Bloc platform, or a specific page:
```ruby
$ irb
kele_client.get_messages
kele_client.get_messages(1)

```
Send a message on the Bloc platform:
```
$ irb
kele_client.create_message("yourBlocEmail@example.com", recipient_id, "optional topic thread","optional subject", "message")
```

Submit your work through the Bloc platform:
```
$ irb
kele_client.create_submission(checkpoint_id, enrollment_id, "assignment_branch", "assignment_commit_link", "comment")
```
