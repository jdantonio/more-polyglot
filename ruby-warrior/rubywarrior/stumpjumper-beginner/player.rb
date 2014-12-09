require 'delegate'

UnexpectedGameStateError = Class.new(StandardError)

class Player

  def play_turn(undecorated_warrior)
    warrior = DecoratedWarrior.new(
      undecorated_warrior,
      initial_game_state(undecorated_warrior),
      last_game_state
    )

    if warrior.confronted_by?(:enemy)
      warrior.attack!
    elsif warrior.taken_damage?
      if warrior.taking_damage?
        warrior.walk!(:forward)
      else
        warrior.rest!
      end
    elsif warrior.can_move?(:forward)
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
end

class GameState

  attr_reader :warrior_health

  def initialize(warrior)
    @warrior_health = warrior.health
  end
end

class DecoratedWarrior < SimpleDelegator

  def initialize(warrior, initial_game_state, last_game_state)
    super(warrior)
    @initial_game_state = initial_game_state
    @last_game_state = last_game_state
  end

  def can_move?(direction = :forward)
    __getobj__.feel(direction.to_sym).empty?
  end

  def confronted_by?(entity)
    __getobj__.feel(:forward).send("#{entity}?".to_sym)
  rescue NoMethodError
    false
  end

  def taking_damage?
    __getobj__.health < @last_game_state.warrior_health
  end

  def taken_damage?
    __getobj__.health < @initial_game_state.warrior_health
  end
end
