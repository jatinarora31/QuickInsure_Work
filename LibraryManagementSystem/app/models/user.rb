class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true, uniqueness: true
    validates :address, presence: true
end
