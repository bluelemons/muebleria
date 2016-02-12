class Turns::Active
  extend Forwardable

  def_delegators :turn, :at

  attr_accessor :turn

  def initialize(turn)
    self.turn = turn
  end

  def to_partial_path
    'turns/active'
  end
end
