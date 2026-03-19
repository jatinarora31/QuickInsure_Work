class Book < ApplicationRecord
  belongs_to :category
  belongs_to :publisher

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :copies, numericality: { greater_than: 0 }

  attr_accessor :copies

  before_create :set_copies

  private

  def set_copies
    self.total_copies = copies
    self.available_copies = copies
  end

  def valid_copies
    if copies.nil? || copies <= 0
      error.add(:copies, "must be greater than 0")
    end
  end
end
