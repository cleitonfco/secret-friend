# encoding: utf-8
require './lib/raffle'

friends = [
  Person.new('Ayla Rocha',     'ayla.rocha@gmail.com'), 
  Person.new('Alyne Bandeira', 'alyneband@hotmail.com'), 
  Person.new('Melissa Rocha',  'melissa.rocha@gmail.com'), 
  Person.new('Idina Lopes',    'idina.lopes@telefonica.com'), 
  Person.new('Carla Adriana',  'carlaadrianaperes@yahoo.com.br'), 
  Person.new('Adenisia Rocha', 'adenisialima@hotmail.com'), 
  Person.new('Regina Maria',   'reginamsa@yahoo.com.br'), 
]

r = Raffle.new(friends)
r.mix
r.send
