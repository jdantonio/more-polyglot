class Player
  def play_turn(warrior)
    if warrior.feel(:forward).empty?
      warrior.walk!
    else
      warrior.attack!
    end
  end
end
