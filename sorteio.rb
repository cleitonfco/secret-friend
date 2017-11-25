# encoding: utf-8
require './lib/person'
require './lib/raffle'

friends = [
  Person.new('Paulo Gustavo',       'paulog@gmail.com'), 
  Person.new('Ayla Maria',          'ayla.rocha@gmail.com'), 
  Person.new('Cleiton Francisco',   'cleitonfco@gmail.com'), 
  Person.new('Adenisia Lima',       'adenisialima@hotmail.com'), 
  Person.new('Rodrigo Chaves',      'rodrigo@jus.com.br'), 
  Person.new('Alysson Daniel',      'alyssondaniel@gmail.com'), 
  Person.new('Mateus Pontes',       'mateuspo10@gmail.com'), 
  Person.new('Elinaldo Nascimento', 'elinaldo.java@gmail.com'), 
  Person.new('José Carvalho',       'carvalho@jus.com.br'), 
  Person.new('Italo Carvalho',      'italo@jus.com.br'), 
]

r = Raffle.new(friends)
r.mix
r.send
