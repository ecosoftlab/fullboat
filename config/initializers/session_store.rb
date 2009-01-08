# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :session_key => '_wrct_session',
  :secret      => '028010d140b4455b9afce903d531fe542486a7b5a99f30fe21ba4407d9d6c47919874502d1d3c8c3018dcc609529cd4ab3ddad1dae87d4316f65c50ff9e689ba'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
