require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Introduction du jeu
def display_intro
  puts "-------------------------------------------------"
  puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"
end

# Création du HumanPlayer
def create_player
  puts "Comment t'appelles-tu, aventurier?"
  print "> "
  player_name = gets.chomp
  HumanPlayer.new(player_name)
end

# Création des bots ennemis
def create_enemies
  [Player.new("Josiane", 10), Player.new("José", 10)]
end

# Affichage de l'état du HumanPlayer + Bots
def display_game_state(human_player, enemies)
  human_player.show_state

  puts "\nQuelle action veux-tu effectuer?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à te soigner"
  puts "\nattaquer un joueur en vue :"
  enemies.each_with_index do |enemy, index|
    puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
  end
end

# Exécute l'action choisie
def perform_player_action(human_player, choice, enemies)
  case choice
  when "a"
    human_player.search_weapon
  when "s"
    human_player.search_health_pack
  when "0", "1"
    target_index = choice.to_i
    if target_index < enemies.length
      human_player.attacks(enemies[target_index])
    else
      puts "Action invalide. Choisis une action correcte."
    end
  else
    puts "Action invalide. Choisis une action correcte."
  end
end

# Exécute les attaques des bots contre le HumanPlayer
def perform_enemy_attacks(human_player, enemies)
  puts "\nLes ennemis t'attaquent !"

  enemies.each do |enemy|
    enemy.attacks(human_player) if enemy.life_points > 0
  end
end

# Affiche le résultat de la partir
def display_game_result(human_player)
  puts "\nLa partie est finie"
  if human_player.life_points > 0
    puts "BRAVO ! TU AS GAGNÉ !"
  else
    puts "Loser ! Tu as perdu"
  end
end

# Exécution du jeu
def run_game
  display_intro
  human_player = create_player
  enemies = create_enemies

  while human_player.life_points > 0 && (enemies.any? { |enemy| enemy.life_points > 0 })
    display_game_state(human_player, enemies)
    print "\nChoisis une action :"
    choice = gets.chomp
    perform_player_action(human_player, choice, enemies)
    perform_enemy_attacks(human_player, enemies)

    enemies.each { |enemy| enemy.announce_death }
    human_player.announce_death
  end
  display_game_result(human_player)
end

run_game

binding.pry