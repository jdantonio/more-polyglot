class InitialGameState

  attr_reader :warrior_max_health
  
  def initialize(warrior)
    @warrior_max_health = warrior.health
  end
end

class Player

  UnexpectedWarriorStateError = Class.new(StandardError)

  def initial_game_state(warrior)
    @initial_game_state ||= InitialGameState.new(warrior).freeze
  end

  def play_turn(warrior)
    init_state = initial_game_state(warrior)

    if facing_enemy?(warrior)
      warrior.attack!
    elsif taken_damage?(warrior, init_state.warrior_max_health)
      warrior.rest!
    elsif can_move_forward?(warrior)
      warrior.walk!(:forward)
    else
      raise UnexpectedWarriorStateError
    end
  end

  def can_move_forward?(warrior)
    warrior.feel(:forward).empty?
  end

  def facing_enemy?(warrior)
    warrior.feel(:forward).enemy?
  end

  def taken_damage?(warrior, max_health)
    warrior.health < max_health
  end
end
