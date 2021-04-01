class Brave
  attr_reader :name, :hp, :offense, :defense
  attr_writer :hp

  CRITICAL＿ATTACK_CONSTANT = 1.5

  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  def attack(monster)
    puts "#{name}の攻撃"

    attack_type = decision_attack_type
    damage = calculate_damage(target:monster, attack_type:attack_type)
    cause_damage(target:monster,damage:damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private

  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage

    target.hp = 0 if target.hp < 0

    puts "#{target.name}に#{damage}ダメージあたえた！"
  end

  def calculate_damage(**params)
    target = params[:target]
    attack_type = params[:attack_type]

    if attack_type == "critical"
      puts "クリティカル！"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end
  end

  def calculate_special_attack
    @offense * CRITICAL＿ATTACK_CONSTANT
  end

  def decision_attack_type
    attack_num = rand(4)

    if attack_num === 0
      "critical"
    else
      "normal"
    end
  end
end


class Monster
  attr_accessor :hp
  attr_reader :name, :offense, :defense

  CALC_HALF_HP = 0.5
  POWER_UP_RATE = 1.5

  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    @transform_falg = false

    @trigger_of_transform = params[:hp] * CALC_HALF_HP

  end

  def attack(brave)
    if self.hp <= @trigger_of_transform && @transform_falg == false
      @transform_falg = true
      transform
    end
    puts "#{name}の攻撃"

    damage = calculate_damage(brave)
    cause_damage(damage:damage, target:brave)

    puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  private

  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage

    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}ダメージをうけた"
  end

  def calculate_damage(target)
    @offense - target.defense
  end

  def transform
    transform_name = "ドラゴン"

    puts <<~EOS
    #{@name}は怒っている
    #{@name}は#{transform_name}に変身した
    EOS

    @offense *= POWER_UP_RATE
    @name = transform_name
  end
end

brave = Brave.new(name: "テリー", hp: 1000, offense: 150, defense: 100)
monster = Monster.new(name: "スライム", hp: 900, offense: 150, defense: 100)

loop do
  brave.attack(monster)
  break if monster.hp <= 0

  monster.attack(brave)
  break if brave.hp <= 0
end

# puts <<~TEXT
# NAME: #{brave.name}
# HP: #{brave.hp}
# OFFENSE: #{brave.offense}
# DEFENSE: #{brave.defense}
# TEXT

# brave.hp -= 30

# puts "#{brave.name}はダメージを受けた！残りHPは#{brave.hp}だ"

# puts <<~TEXT
# NAME: #{monster.name}
# HP: #{monster.hp}
# OFFENSE: #{monster.offense}
# DEFENSE: #{monster.defense}
# TEXT


