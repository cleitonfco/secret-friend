# encoding: utf-8
require 'rubygems'
require 'mail'
require 'config/mail'

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
      msg = zoeira_message(config[:name], config[:friend])
      mail = Mail.new do
        content_type 'text/plain; charset=UTF-8'
        from         'naoresponder@jus.com.br'   # Configure aqui o e-mail do remetente
        to           config[:email]
        subject      'Amigo Oculto Jus.com.br 2017'
        body         msg
      end

      mail.deliver!
    end

    def zoeira_message(name, friend)
%{Oi #{name},

É hora de mostrar que você tem senso de humor e que vai ajudar a trolar sadiamente os seus amigos e amigas da empresa.

Atenção: você pode ZOAR quantos amigos você quiser, mas o escolhido desse ano será:

  #{friend.upcase}

Guarde este nome só pra você, memorize-o e apague este email para garantir o sigilo dessa informação.

Não que vá ter alguma dica útil (neste caso), mas não custa nada recomendar uma passada no http://jusfriends.herokuapp.com/

** The zoeira is beginning and never ends. **
}
    end

    def body_message(name, friend)
%{Oi #{name},

Você está participando do Amigo Oculto do Jus.com.br 2017 e #{friend}

Guarde este nome só pra você, memorize-o e apague este email para garantir o sigilo dessa informação.

Agora que você já sabe quem você tirou, corra pro http://jusfriends.herokuapp.com/, lá você pode cadastrar dicas
do que você quer ganhar, ver as dicas do que comprar e ainda pode fazer perguntas e/ou comentários 
totalmente "anônimos" (sigilo absoluto) para conhecer melhor as preferências do(a) amigo(a) acima.

PS: Se você ainda não tem cadastro no JusFriends, acesse aqui: http://jusfriends.herokuapp.com/cadastro.

Boas Festas.
-----------------------
Esta mensagem foi enviada automaticamente, portanto o sigilo dela só depende de você. :)
}
    end
end

