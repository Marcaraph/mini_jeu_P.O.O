require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Affiche l'état des joueurs
def display_player_state(player1, player2)
  puts "\nVoici l'état de nos joueurs :"
  puts "#{player1.show_state}\n#{player2.show_state}"
end

# Phase attaque des joueurs
def attack_phase(player1, player2)
  puts "Passons à la phase d'attaque :"
  player1.attacks(player2)
  return if player2.life_points <= 0
  player2.attacks(player1)
  display_player_state(player1, player2)
end

# Affiche le résultat final
def end_combat(player1, player2)
  puts "\nLe combat est terminé !"
  puts "Voici le résultat final :"
  display_player_state(player1, player2)
end

# Exécute le jeu
def run_game
  # Création des joueurs
  player1 = Player.new("Josiane", 10)
  player2 = Player.new("José", 10)

  # Affiche l'état initial des joueurs
  display_player_state(player1, player2)

  # Boucle du combat
  while player1.life_points > 0 && player2.life_points > 0
    attack_phase(player1, player2)
    player1.announce_death
    player2.announce_death
  end

  # Affiche le résultat final
  end_combat(player1, player2)
end

run_game

binding.pry