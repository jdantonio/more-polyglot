UnexpectedGameStateError = Class.new(StandardError)

class GameState

  attr_reader :warrior_health
  
  def initialize(warrior)
    @warrior_health = warrior.health
  end
end

class Player

  def play_turn(warrior)
    init_state = initial_game_state(warrior)

    if confronted_by?(:enemy, warrior)
      warrior.attack!
    elsif taken_damage?(warrior, init_state)
      if taken_damage?(warrior, last_game_state)
        warrior.walk!(:forward)
      else
        warrior.rest!
      end
    elsif can_move_forward?(warrior)
      warrior.walk!(:forward)
    else
      raise UnexpectedGameStateError
    end

    save_current_game_state(warrior)
  end

  ## game state

  attr_reader :last_game_state

  def initial_game_state(warrior)
    if @initial_game_state.nil?
      @initial_game_state = GameState.new(warrior).freeze
      save_current_game_state(warrior)
    end
    @initial_game_state
  end

  def save_current_game_state(warrior)
    @last_game_state = GameState.new(warrior).freeze
  end

  ## warrior status

  def can_move_forward?(warrior)
    warrior.feel(:forward).empty?
  end

  def confronted_by?(entity, warrior)
    warrior.feel(:forward).send("#{entity}?".to_sym)
  rescue NoMethodError
    false
  end

  def taken_damage?(warrior, game_state)
    warrior.health < game_state.warrior_health
  end
end
