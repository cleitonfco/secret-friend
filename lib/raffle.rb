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

  def select(raffle)
    raffle.knuth_shuffle
    valids = raffle.shuffle - [self]
    friend = valids.shift
    raffle.shuffle -= [friend]
    raise 'Conflito no Sorteio. Não foi possível selecionar um amigo.' unless friend
    self.friend = friend.name
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
      config[:email] = p.email
      config[:name] = p.name
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
        subject      'Amigo Oculto Jus.com.br 2016'
        body         <<-EOF
Oi #{config[:name]},

Você está participando do TESTE DO AMIGO OCULTO do Jus Navigandi 2015 e seu(sua) Amigo(a) é: #{config[:friend]}

Guarde este nome só pra você, memorize-o e apague este email para garantir o sigilo dessa informação.

Agora que você já sabe quem você tirou, corra pro http://jusfriends.herokuapp.com/, lá você pode cadastrar dicas
do que você quer ganhar, ver as dicas do que comprar e ainda pode fazer perguntas e/ou comentários 
totalmente "anônimos" (sigilo absoluto) para conhecer melhor as preferências do(a) amigo(a) acima.

PS: Se você ainda não tem cadastro no JusFriends, acesse aqui: http://jusfriends.herokuapp.com/cadastro.

Boas Festas.
-----------------------
Esta mensagem foi enviada automaticamente, portanto o sigilo dela só depende de você. :)
EOF
#         subject      'Tá na hora de fazer com um amigo seu o que 2016 fez com você'
#         body         <<-EOF
# Oi #{config[:name]},

# 2016 foi um ano, digamos assim, criativo. E já que essa temporada foi mais carregada no quesito ZOEIRA, você não vai deixar
# terminar impunimente. Mostre seu senso de humor e ajude a trolar sadiamente os seus amigos e amigas da empresa.

# Atenção: você pode ZOAR quantos amigos você quiser, mas o seu alvo primário é:

#   #{config[:friend].upcase}

# Guarde este nome só pra você, memorize-o e apague este email para garantir o sigilo dessa informação.

# Não que vá ter alguma dica útil, mas não custa nada recomendar uma passada no http://jusfriends.herokuapp.com/

# ** The zoeira is beginning and never ends. **
# EOF
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
