# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  ticket_id  :integer
#  tech_id    :integer
#  user_id    :integer
#  score_id   :integer
#  state      :string(255)
#  comments   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Survey do
  pending "add some examples to (or delete) #{__FILE__}"
end
