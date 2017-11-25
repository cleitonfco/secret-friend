Mail.defaults do
  delivery_method :smtp, { 
    :address => 'smtp.gmail.com',
    :port => 587,
    :user_name => "naoresponder@jus.com.br",
    :password => "m2E9lXi9s7s8A",
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end