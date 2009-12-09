require 'rubygems'
require 'action_mailer'

class Raffle
  attr_accessor :participants

  def initialize(participants = [])
    @participants = participants
    @shuffle = @participants.shuffle
  end

  def shift(exclude = '')
    f = @shuffle.first
    if f.first == exclude
      @shuffle.shift
      @shuffle.push(f)
      return shift(exclude)
    end
    @shuffle.shift[1]
  end

  def mix
    return @mix if @mix && !@mix.empty?
    @mix = {}
    @participants.each do |p|
      @mix[p.first] = shift(p.first)
    end
    @mix
  end

  def send
    config = {}
    mix.each do |key, value|
      config[:email] = @participants.assoc(key)[0]
      config[:name] = @participants.assoc(key)[1]
      config[:friend] = value
      Notifier.deliver_email(config)
    end
  end
end

class Notifier < ActionMailer::Base
  def email(config)
    recipients    config[:email]
    from          "naoreponder@jus.com.br"
    subject       "Jus Amigo Oculto 2009"
    content_type  "text/plain"
    body          :name => config[:name], :friend => config[:friend]
  end
end

Notifier.template_root = File.dirname(__FILE__)

ActionMailer::Base.smtp_settings = {
  :address  => "smtp",
  :port  => 25, 
  :domain => "domain",
  :user_name  => "user",
  :password  => "password",
  :authentication  => :login
}

