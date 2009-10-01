# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tender_session',
  :secret      => 'd36dd54dbedc91f53a0f908ef096bbce4a861412841738b62acb123abb70d85da83fe4fd2ea5be990e1fd56cd99b1da681944c0463de535ffc9a2c98674ac4eb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
