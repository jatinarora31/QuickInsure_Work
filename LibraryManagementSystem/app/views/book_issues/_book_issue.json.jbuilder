json.extract! book_issue, :id, :book_id, :user_id, :issue_date, :due_date, :return_date, :created_at, :updated_at
json.url book_issue_url(book_issue, format: :json)
