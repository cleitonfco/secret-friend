# encoding: utf-8
require 'rubygems'
require 'mail'
require 'pry'

class Person
  attr_accessor :name, :email, :friend
  
  def initialize(name, email)
    @name, @email, @friend = name, email, nil
  end

  def to_s
    "#{@name}: #{@email}"
  end
end

class Raffle
  attr_accessor :participants

  def initialize(participants = [])
    @participants = participants
    @shuffle = @participants
    @raffleds = []
    @mix = nil
    rand(100).times { @shuffle = @shuffle.shuffle }
  end

  def select(person)
    friend = @shuffle.shuffle!.shift
    if friend == person
      @shuffle.push(person)
      puts "***** CONFLITO: #{friend} = #{person}. Buscando outro amigo! *****"
      return select(person)
    end
    person.friend = friend.name
    person
  end

  def mix
    return @mix if @mix && !@mix.empty?
    @mix = @participants.map { |p| select(p) }
  end

  def send
    config = {}
    mix.each do |p|
      config[:email] = p.email
      config[:name] = p.name
      config[:friend] = p.friend
      prepare_mail(config)
    end
  end

  protected
    def prepare_mail(config)
      mail = Mail.new do
        content_type 'text/plain; charset=UTF-8'
        from         'email@gmail.com'   # Configure aqui o e-mail do remetente
        to           config[:email]
        subject      'Amigo Oculto 2014'
        body         <<-EOF
Oi #{config[:name]},

Você está participando do AMIGO OCULTO 2014 e seu Amigo é: #{config[:friend]}

Boas Festas.
-----------------------
Esta mensagem foi enviada automaticamente, portanto o sigilo dela só depende de você. :-)}
EOF
      end

      mail.deliver!
    end
end

Mail.defaults do
  delivery_method :smtp, { 
    :address => 'smtp.gmail.com',
    :port => 587,
    :user_name => "email@gmail.com",  # Configure aqui o e-mail de login
    :password => "***********",       # Configure aqui a senha do usuario acima
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end
