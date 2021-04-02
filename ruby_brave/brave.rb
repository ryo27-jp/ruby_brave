require './character'

class Brave < Character

  CRITICAL＿ATTACK_CONSTANT = 1.5

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
