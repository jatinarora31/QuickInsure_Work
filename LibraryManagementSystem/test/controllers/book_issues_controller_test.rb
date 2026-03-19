require "test_helper"

class BookIssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_issue = book_issues(:one)
  end

  test "should get index" do
    get book_issues_url, as: :json
    assert_response :success
  end

  test "should create book_issue" do
    assert_difference("BookIssue.count") do
      post book_issues_url, params: { book_issue: { book_id: @book_issue.book_id, due_date: @book_issue.due_date, issue_date: @book_issue.issue_date, return_date: @book_issue.return_date, user_id: @book_issue.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show book_issue" do
    get book_issue_url(@book_issue), as: :json
    assert_response :success
  end

  test "should update book_issue" do
    patch book_issue_url(@book_issue), params: { book_issue: { book_id: @book_issue.book_id, due_date: @book_issue.due_date, issue_date: @book_issue.issue_date, return_date: @book_issue.return_date, user_id: @book_issue.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy book_issue" do
    assert_difference("BookIssue.count", -1) do
      delete book_issue_url(@book_issue), as: :json
    end

    assert_response :no_content
  end
end
