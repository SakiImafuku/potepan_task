class Potepan::Suggest < ApplicationRecord
  self.table_name = "potepan_suggests"

  scope :filter, ->(keyword, max_num) { where("keyword LIKE?", "#{keyword}%").limit(max_num) }
end
