require 'test_helper'
require 'minitest/mock'

class TurnDecoratorTest < ActiveSupport::TestCase
  def at
    Time.new(2016, 2, 9)
  end

  def turn
    @turn ||= TurnBuilder.new(at)
  end

  test 'a turn is expired when the date is already in the past' do
    Time.stub(:now, Time.new(2016, 2, 10)) do
      assert turn.expired?
    end
  end

  test 'a turn is a new one is there is no visit on that day' do
    Turn.stub(:where, []) do
      assert turn.new?
    end
  end

  test 'build should return an active turn instance when the turn exists' do
    turn.stub(:expired?, false) do
      turn.stub(:new?, false) do
        assert turn.build.class == Turns::Active
      end
    end
  end

  test 'build should return an expired turn instance for expired turns' do
    turn.stub(:expired?, true) do
      assert turn.build.class == Turns::Expired
    end
  end

  test 'build should return a new turn instance when the turn dont exists' do
    turn.stub(:expired?, false) do
      turn.stub(:new?, true) do
        assert turn.build.class == Turns::New
      end
    end
  end

  test 'should create an array of turns for an array of dates' do
    today = Time.now.to_date
    tomorrow = today + 1.days
    days = (today ... tomorrow)
    turn_builder = TurnBuilder.build days
    assert turn_builder.class == Array
    assert turn_builder.first.class.name.include? 'Turns'
    assert turn_builder.last.class.name.include? 'Turns'
  end
end
