# encoding: utf-8
require './lib/person'
require './lib/raffle'

friends = [
  Person.new('José Carvalho',        'carvalho@jus.com.br'), 
  Person.new('Elinaldo Nascimento',  'elinaldo.java@gmail.com'), 
  Person.new('Ayla Maria',           'ayla.rocha@gmail.com'), 
  Person.new('Adenisia Lima',        'adenisialima@hotmail.com'), 
  Person.new('Rodrigo Chaves',       'rodrigo@jus.com.br'), 
  Person.new('Wellington (Sorriso)', 'sorriso@jus.com.br'), 
  Person.new('Cleiton Francisco',    'cleitonfco@gmail.com'), 
  Person.new('Paulo Gustavo',        'paulog@gmail.com'), 
]

r = Raffle.new(friends)
r.mix
r.send
