class Page < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true, allow_blank: false
end
