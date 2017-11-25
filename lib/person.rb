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
