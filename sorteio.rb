# encoding: utf-8
require './lib/raffle'

friends = [
  Person.new('Adenisia Rocha',   'adenisialima@hotmail.com',      'F'), 
  Person.new('Moara Dantad',     'moaradantas@gmail.com',         'F'), 
  Person.new('Karolynni Falcao', 'kalufalcao9@gmail.com',         'F'), 
  Person.new('Camila Gomes',     'adv.camilagomes@gmail.com',     'F'), 
  Person.new('Yako Guerra',      'yakowenko@gmail.com',           'M'), 
  Person.new('Adriana Anjos',    'adrianaanjos@hotmail.com',      'F'), 
  Person.new('Lourdes',          'lourdesdanae@yahoo.com.br',     'F'), 
  Person.new('Larissa Mendes',   'lmendes1985@hotmail.com',       'F'), 
  Person.new('Leo Leal',         'leofleal80@gmail.com',          'M'), 
  Person.new('Débora Martins',   'deboramartins.adv@hotmail.com', 'F'), 
  Person.new('Karina Campelo',   'karinacampelo@hotmail.com',     'F'), 
]

r = Raffle.new(friends)
r.mix
r.send
