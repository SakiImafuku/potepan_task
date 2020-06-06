class Potepan::Suggest < ApplicationRecord
  self.table_name = "potepan_suggests"

  def self.filter(keyword)
    Potepan::Suggest.all.where("keyword LIKE?", "#{keyword}%")
  end
end
