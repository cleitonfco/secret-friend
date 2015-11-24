# encoding: utf-8
require './lib/raffle'

friends = [
  Person.new('Alysson Daniel', 'alysson@jus.com.br'), 
  Person.new('Ayla Maria', 'ayla@jus.com.br'), 
  Person.new('Cleiton Francisco', 'cleiton@jus.com.br'), 
  Person.new('Elinaldo Nascimento', 'elinaldo@jus.com.br'), 
  Person.new('Mateus Pontes', 'mateus@jus.com.br'), 
  Person.new('Paulo Gustavo', 'paulo@jus.com.br'), 
  Person.new('Adenisia', 'adenisia@jus.com.br'), 
  Person.new('Rodrigo', 'rodrigo@jus.com.br'), 
  Person.new('Carvalho', 'carvalho@jus.com.br'), 
  Person.new('Italo', 'italo@jus.com.br'), 
  Person.new('Igor', 'igor@jus.com.br')
]

10.times do |x|
	puts "=== Sorteio Nº #{x} ==="
	puts "-----------------------"
	r = Raffle.new(friends)
	r.mix
	r.send
	puts "+++++++++++++++++++++++"
	puts ""
end
