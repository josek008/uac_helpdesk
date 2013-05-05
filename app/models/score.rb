class Score < ActiveRecord::Base
  attr_accessible :description

  has_one :survey

end
