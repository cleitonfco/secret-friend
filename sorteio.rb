# encoding: utf-8
require './lib/raffle'

friends = [
  Person.new('Nome Participante', 'email@participante.com'), 
  Person.new('Nome Participante', 'email@participante.com'), 
  Person.new('Nome Participante', 'email@participante.com'), 
  Person.new('Nome Participante', 'email@participante.com'), 
  Person.new('Nome Participante', 'email@participante.com'), 
  Person.new('Nome Participante', 'email@participante.com')
]

r = Raffle.new(friends)
r.mix
r.send
