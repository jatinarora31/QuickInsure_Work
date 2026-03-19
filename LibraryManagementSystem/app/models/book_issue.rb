class BookIssue < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book_id, presence: true
  validates :user_id, presence: true

  validate :check_book_availability
  validate :book_already_issued

  before_create :set_dates
  after_create :decrease_available_copies
  after_update :increase_available_copies, if: :returned?

  private

  def set_dates
    self.issue_date = Date.today
    self.due_date = Date.today + 7
  end

  def check_book_availability
    if book.nil?
      errors.add(:book, "not found")
    elsif book.available_copies <= 0
      errors.add(:book, "Book not available!")
    end
  end
  
  def decrease_available_copies
    book.decrement!(:available_copies)
  end

  def returned?
    saved_change_to_return_date? && return_date.present?
  end

  def increase_available_copies
    book.increment!(:available_copies)
  end

  def book_already_issued
    return if user.nil? || book_id.nil?
    if user.book_issues.where(book_id: book_id, return_date: nil).exists?
      errors.add(:book, "Book already issued to this user")
    end
  end
end
