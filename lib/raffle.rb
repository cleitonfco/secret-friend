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
    @shuffle.shift
  end

  def mix
    return @mix if @mix && !@mix.empty?
    @mix = {}
    @participants.each do |p|
      @mix[p.first] = shift(p.first)
    end
    @mix
  end

  def pointer
    point = mix.keys.first.to_s
    s = "#{point} > "
    useds = [point]

    (1..mix.size).each do |v|
      point = mix.fetch(point)
      s << point
      if useds.include?(point)
        s << " | "
        w = mix.delete(point)
        (0..mix.keys.size - 1).each do |n|
          if !useds.include?(mix.keys[n].to_s)
            point = mix.keys[n].to_s
            s << "#{point} > "
            break
          end
        end
      else
        s << " > "
      end
      useds << point
    end
    s.sub(/ \| $/, '')
  end

  def send
    mix.each do |key, value|
      
    end
  end
end
