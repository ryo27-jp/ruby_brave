require './character'
require './brave'
require './monster'
require './games_controller'

games_controller = Games_controller.new

terry = Brave.new(name: "テリー", hp: 1000, offense: 150, defense: 100)
slime = Monster.new(name: "スライム", hp: 800, offense: 150, defense: 100)

games_controller.battle(brave:terry, monster:slime)



