class Calendar
  extend Forwardable

  def_delegators :@at, :at_beginning_of_week

  def initialize(at = Time.now.to_date)
    @at = at
  end

  def build_week
    week.to_a
  end

  private

  def week
    (at_beginning_of_week ... at_beginning_of_week + 7.days)
  end
end
