class TurnBuilder

  def self.build(days)
    days.map { |day| new(day).build }
  end

  def initialize(at)
    @at = at
  end

  def expired?
    @at < Time.now.to_date
  end

  def new?
    !turn
  end

  def build
    return Turns::Expired.new(@at) if expired?
    return Turns::New.new(@at) if new?
    Turns::Active.new(turn)
  end

  private

  def turn
    Turn.where(at: @at).first
  end
end
