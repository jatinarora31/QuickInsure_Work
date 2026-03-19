class Publisher < ApplicationRecord
    validates :publisher_name, presence: true
    validates :nationality, presence: true
    validates :address, presence: true
    has_many :books
end