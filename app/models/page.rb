class Page < ActiveRecord::Base
  has_many :contents, dependent: :destroy
  validates :url, presence: true, uniqueness: true, allow_blank: false
end
