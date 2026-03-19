class Author < ApplicationRecord
    validates :author_name, presence: true
    validates :nationality, presence: true
    validates :birth_year, presence: true

    has_many :book_authors, dependent: :destroy
    has_many :books, through: :book_authors
end
