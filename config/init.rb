# Move this to application.rb if you want it to be reloadable in dev mode.
Merb::Router.prepare do |r|
  r.resource :contacts
  
  r.default_routes
end


Merb::Config.use { |c|
  c[:environment]         = 'production',
  c[:framework]           = {},
  c[:log_level]           = 'debug',
  c[:use_mutex]           = false,
  c[:session_store]       = 'cookie',
  c[:session_id_key]      = '_session_id',
  c[:session_secret_key]  = '4918205d5c09968fc927b3878413c8ae7cf09685',
  c[:exception_details]   = true,
  c[:reload_classes]      = true,
  c[:reload_time]         = 0.5
}

require "merb-mailer"
dependency 'dm-core'
dependency "merb_helpers"

# Settings for Merb mailer
Merb::Mailer.config = {
    :host   => 'mail.example.com',
    :port   => '25',
    :user   => 'test@example.com',
    :pass   => '',
    :auth   => :plain,
    :domain => "example.com" # the HELO domain provided by the client to the server
  }

