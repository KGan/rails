# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  type       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    title Faker::Lorem.words(3).join(' ')
    user_id 1
    goaltype Goal::TYPES.sample
    status Goal::STATUSES.sample
  end

end
