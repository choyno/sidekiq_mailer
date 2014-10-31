# Be sure to restart your server when you modify this file.

SidekiqMailer::Application.config.session_store :cookie_store, key: '_sidekiq_mailer_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# SidekiqMailer::Application.config.session_store :active_record_store
