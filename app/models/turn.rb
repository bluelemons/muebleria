class Turn < ActiveRecord::Base
  has_many :visit

  delegate :zones, to: :visit
end
