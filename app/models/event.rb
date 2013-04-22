class Event < ActiveRecord::Base
  attr_accessible :event_descr

  validates :event_descr, presence: true, uniqueness: true
end
