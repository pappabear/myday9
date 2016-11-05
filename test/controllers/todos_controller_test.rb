require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest


  setup do
    @todo = todos(:one)
    @user = users(:chip)
  end


  test "should redirect index when not logged in" do
    get today_path
    assert_redirected_to login_path
  end


  test "should redirect edit when not logged in" do
    get edit_todo_path(@todo)
    assert_redirected_to login_url
  end


  test "should get today" do
    log_in_as(@user)
    get today_path
    assert_response :success
    assert_not_nil assigns(:todos)
  end


  test "should get tomorrow" do
    log_in_as(@user)
    get tomorrow_path
    assert_response :success
    assert_not_nil assigns(:todos)
  end


  test "should get index" do
    log_in_as(@user)
    get todos_path, params: { d: '2015-05-30' }  
    assert_response :success
    assert_not_nil assigns(:todos)
  end


  test "should goto today when index is called with no date" do
    log_in_as(@user)
    get todos_path
    assert_redirected_to today_path
  end


  test "should add an item" do
    log_in_as(@user)
    b = Date.today.strftime('%m/%d/%Y')

    get new_todo_path
    assert_difference 'Todo.count', 1 do
      post todos_path, params: { todo: { subject: 'test', 
                                         due_date: b, 
                                         recurrence: 1, 
                                         is_complete: false, 
                                         user_id: 1 } }
    end
  end


  test "should delete an item" do
    log_in_as(@user)
    assert_difference 'Todo.count', -1 do
      delete todo_path(@todo) 
    end
  end


  test "should update an item" do
    log_in_as(@user)
    subj  = "Foo Bar"
    patch todo_path(@todo), params: { todo: { subject:  subj} }
    assert_redirected_to today_path
    @todo.reload
    assert_equal subj,  @todo.subject
  end


  test "should mark an item complete" do
    log_in_as(@user)
    put mark_complete_path(@todo), params: { todo: { is_complete:  true} }
    test = Todo.find(@todo.id)
    assert_equal true, test.is_complete?
  end


  test "should mark an item NOT complete" do
    log_in_as(@user)
    put mark_incomplete_path(@todo), params: { todo: { is_complete:  false} }
    test = Todo.find(@todo.id)
    assert_equal false, test.is_complete?
  end


  test "should skip this item" do
    log_in_as(@user)
    put todo_skip_path(@todo)
    test = Todo.find(@todo.id)
    assert_equal Date.tomorrow, test.due_date
  end


end
