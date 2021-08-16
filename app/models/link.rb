class Link < ApplicationRecord
  validates :fintoc_id, :presence => true
  validates :fintoc_token, :presence => true
end
