# encoding: utf-8
require 'rubygems'
require 'mail'
require 'pry'

class Person
  attr_accessor :name, :email, :gender, :friend
  
  def initialize(name, email, gender)
    @name, @email, @gender, @friend = name, email, gender, nil
  end

  def to_s
    "#{@name}: #{@email}"
  end

  def select(raffle)
    raffle.knuth_shuffle
    valids = raffle.shuffle - [self]
    friend = valids.shift
    raffle.shuffle -= [friend]
    raise 'Conflito no Sorteio. Não foi possível selecionar um amigo.' unless friend
    self.friend = friend
    self
  end
end

class Raffle
  attr_accessor :participants, :shuffle

  def initialize(participants = [])
    @mix = nil
    @participants = participants
    reload_shuffle
  end

  def reload_shuffle
    @shuffle = @participants.dup
    knuth_shuffle
  end

  def knuth_shuffle
    j = @shuffle.length
    i = 0
    while j > 1
      r = i + rand(j)
      @shuffle[i], @shuffle[r] = @shuffle[r], @shuffle[i]
      i += 1
      j -= 1
    end
    @shuffle
  end

  def mix
    return @mix if @mix && !@mix.empty?
    begin
      @mix = @participants.map { |p| p.select(self) }
    rescue
      reload_shuffle
      mix
    end
  end

  def send
    puts "PREPARANDO PRA ENVIAR"
    config = {}
    mix.each do |p|
      config[:email]  = p.email
      config[:name]   = p.name
      config[:gender] = p.gender
      config[:friend] = p.friend
      prepare_mail(config) if mix.size == @participants.size
    end
  end

  protected
    def prepare_mail(config)
      mail = Mail.new do
        content_type 'text/plain; charset=UTF-8'
        from         'naoresponder@jus.com.br'   # Configure aqui o e-mail do remetente
        to           config[:email]
        bcc          'cleitonfco@gmail.com'
        subject      'Amigo oculto Inspire 2016'
        body         <<-EOF
#{config[:gender] == "M" ? "Querido" : "Querida"} #{config[:name]},

#{config[:friend].gender == "M" ? "Seu inspirado oculto é" : "Sua inspirada oculta é"} #{config[:friend].name.upcase}.

A confraternização será no dia 16/12.

Local a confirmar.

Boas festas.
EOF
      end

      mail.deliver!
    end
end

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
