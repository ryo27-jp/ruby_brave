class Blave
  attr_reader :name
  attr_reader :hp
  attr_reader :offense
  attr_reader :defense

  def initialize(name:, hp:, offense:, defense:)
    @name = name
    @hp = hp
    @offense = offense
    @defense = defense
  end
end

  brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

  puts << ~TEXT
  NAME: #{brave.name}
  HP: #{brave.hp}
  OFFENSE: #{brave.offense}
  DEFENSE: #{brave.defense}
  TEXT
