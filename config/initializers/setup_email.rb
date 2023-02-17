ActionMailer::Base.default_url_options = { :host => 'pingcoders.onrender.com' }
ActionMailer::Base.smtp_settings = {
    user_name: "sriram14641@gmail.com",
    password: ENV["google_app_password"],
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    authentication: 'plain',
    enable_starttls_auto: true,
    openssl_verify_mode: "none",
}
