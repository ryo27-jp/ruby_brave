require './character'

class Monster < Character

  CALC_HALF_HP = 0.5
  POWER_UP_RATE = 1.5

  def initialize(params)
    super(
      name:params[:name],
      hp:params[:hp],
      offense: params[:offense],
      defense:params[:defense]
    )
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