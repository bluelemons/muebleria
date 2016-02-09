class Turns::Expired
  attr_accessor :at

  def initialize(at)
    self.at = at
  end

  def to_partial_path
    'turns/expired'
  end
end
