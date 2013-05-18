# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  description     :string(255)
#  state           :string(255)
#  closing_token   :string(255)
#  resolution_date :datetime
#  closed_date     :datetime
#  user_id         :integer
#  ticket_type_id  :integer          default(2)
#  category_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Ticket do
  pending "add some examples to (or delete) #{__FILE__}"
end
