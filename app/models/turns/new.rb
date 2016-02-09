class Turns::New
  attr_accessor :at

  def initialize(at)
    self.at = at
  end

  def to_partial_path
    'turns/new'
  end
end
