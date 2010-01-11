# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_foobar_session',
  :secret      => '0ac758effe76be0ce9d18f06533197a8fbc09632daa0cd7f63ec8d92e83a6f1490abae1a375816025d55dc6152ec25665bcd43404a17f963a6d78bba88144d2c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
