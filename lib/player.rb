class Player
  attr_accessor :name, :life_points
  @@all_player = []

  def initialize(name_to_save, life_points_to_save)
    @name = name_to_save
    @life_points = life_points_to_save
    @@all_player << self
  end

  def show_state
    puts "#{name} a #{life_points} points de vie."
  end

  def gets_damage(damage, attacker)
    @life_points -= damage
    @life_points = 0 if @life_points < 0
  end

  def announce_death
    puts "#{name} a été tué(e) !" if @life_points <= 0
  end

  def attacks(target_player)
    puts "#{name} attaque #{target_player.name} !"
    damage = compute_damage
    target_player.gets_damage(damage, self)
    puts "Il/Elle lui inflige #{damage} points de dégâts."
  end

  private

  def compute_damage
    rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
  super(name, 100)
  @weapon_level = 1
  end

  def show_state
    puts "#{name} a #{life_points} points de vie et une arme de niveau #{weapon_level}."
  end

  def search_weapon
    weapon_found = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{weapon_found}." 
    if weapon_found > weapon_level
      @weapon_level = weapon_found
      puts "Youhou ! Elle est meilleure que ton arme actuelle : tu l'équippes immédiatement !"
    else
      puts "M@*#$... Elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    health_pack = rand(1..6)

    if health_pack == 1
      puts "Tu n'as rien trouvé."
    elsif (2..5).include?(health_pack)
      @life_points = [life_points + 50, 100].min
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    elsif health_pack == 6
      @life_points = [life_points + 80, 100].min
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end

  private

  def compute_damage
    rand(1..6) * @weapon_level
  end
end