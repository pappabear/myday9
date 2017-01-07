class TodosController < ApplicationController

  before_action :logged_in_user  #, only: [:new, :create, :edit, :update, :destroy, :index, :today, :tomorrow]
  before_action :set_todo, only: [:show, :edit, :update, :destroy]


  def today
    session[:working_date] = Date.today.strftime("%m/%d/%Y")
    @todo = Todo.new
    @todos = Todo.where('user_id=?', current_user.id)
                 .where('(is_complete is null and due_date<?) or (due_date=?)', Date.today, Date.today)
                 .order('is_complete desc').order('position')
    session[:path] = 'Today'
  end


  def new
    @todo = Todo.new
    @todo.due_date = session[:working_date] #Date.today.strftime("%m/%d/%Y")
  end


  def create
    @todo = Todo.new(todo_params)
    @todo.user_id=current_user.id

    respond_to do |format|
      if @todo.save
        session[:working_date] = @todo.due_date.strftime("%m/%d/%Y")
        format.html {
          flash[:success] = "Todo was successfully created."
          @todos = determine_todos_as_determined_by_working_date
          redirect_to get_path_in_context  #today_path
        }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end

  end


  def edit
    @todo.due_date = @todo.due_date.strftime("%m/%d/%Y") unless @todo.due_date.nil?
  end


  def update
    @todo = Todo.find(params[:id])
    @todo.update_attributes(todo_params)
    
    if params[:todo]['is_complete'] == "0"
      @todo.is_complete = nil
    else
      @todo.is_complete = true
    end
    
    @todo.user_id=current_user.id

    respond_to do |format|
      if @todo.save
        session[:working_date] = @todo.due_date.strftime("%m/%d/%Y")
        format.html {
          flash[:success] = "Todo was successfully updated."
          @todos = determine_todos_as_determined_by_working_date
          redirect_to get_path_in_context  #today_path
        }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end


  def mark_complete
    @item = Todo.find(params[:id])

    if !@item.recurrence.nil?
      new_item = Todo.new
      new_item.subject = @item.subject
      new_item.recurrence = @item.recurrence

      if new_item.recurrence == 1
        # --- find any item with this subject tomorrow, if exists and incomplete then do NOT create again
        if Todo.where('subject = ?', @item.subject).where('due_date = ?', @item.due_date.advance(:days=>1)).count == 0
          new_item.due_date = @item.due_date.advance(:days=>1)
          new_item.user_id = current_user.id
          new_item.save!
        end
      elsif new_item.recurrence == 2
        # --- find an item with this subject next week, if exists and incomplete then do NOT create again
        match = Todo.where('subject = ?', @item.subject).where('due_date = ?', @item.due_date.advance(:weeks=>1)).first
        if match.nil?
          new_item.due_date = @item.due_date.advance(:weeks=>1)
          new_item.user_id=current_user.id
          new_item.save!
        end
      elsif new_item.recurrence == 3
        # --- find an item with this subject in 2 weeks, if exists and incomplete then do NOT create again
        match = Todo.where('subject = ?', @item.subject).where('due_date = ?', @item.due_date.advance(:weeks=>2)).first
        if match.nil?
          new_item.due_date = @item.due_date.advance(:weeks=>2)
          new_item.user_id=current_user.id
          new_item.save!
        end
      else
        # --- find an item with this subject in a month, if exists and incomplete then do NOT create again
        match = Todo.where('subject = ?', @item.subject).where('due_date = ?', @item.due_date.advance(:months=>1)).first
        if match.nil?
          new_item.due_date = @item.due_date.advance(:months=>1)
          new_item.user_id=current_user.id
          new_item.save!
        end
      end
    end

    @item.update_attribute('is_complete', true)
    @item.save!
    @todos = determine_todos_as_determined_by_working_date
    redirect_to get_path_in_context  #today_path
  end


  def mark_incomplete
    @item = Todo.find(params[:id])
    @item.update_attribute('is_complete', nil)
    @item.save!
    @todos = determine_todos_as_determined_by_working_date
    redirect_to get_path_in_context  #today_path
  end


  def skip
    @todo = Todo.find(params[:id])

    if @todo.recurrence <= 1
      newDate = @todo.due_date.to_date.advance(:days=>1)
    elsif @todo.recurrence == 2
      newDate = @todo.due_date.to_date.advance(:weeks=>1)
    elsif @todo.recurrence == 3
      newDate = @todo.due_date.to_date.advance(:weeks=>2)
    else
      newDate = @todo.due_date.to_date.advance(:months=>1)
    end

    @todo.update_attribute('due_date', newDate)
    @todo.save

    @todos = determine_todos_as_determined_by_working_date
    redirect_to get_path_in_context  #today_path
  end


  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    @todos = determine_todos_as_determined_by_working_date
    redirect_to get_path_in_context  #today_path
  end


  def sort
    puts 'sort params=' + params['todo'].to_s
    @todos = Todo.where('id in (?)', params['todo'])

    @todos.each do |w|
      w.position = params['todo'].index(w.id.to_s) + 1
      w.save!
    end

    render :nothing => true
  end


  def tomorrow
    session[:working_date] = Date.tomorrow.strftime("%m/%d/%Y")
    @todo = Todo.new
    @todos = Todo.where('user_id=?', current_user.id)
                 .where('due_date=?', Date.tomorrow)
                 .order('position')
    session[:path] = 'Tomorrow'
  end


  def someday
    @todo = Todo.new
    @todos = Todo.where('user_id=?', current_user.id)
                 .where('due_date IS NULL')
                 .order('position')
    session[:path] = 'Someday'
  end


  def index
    if params['d'].nil?
      flash[:danger] = 'You cannot view all todos. You must specify a date.'
      redirect_to get_path_in_context  #today_path
      return
    end

    session[:working_date] = params['d'].to_date.strftime("%m/%d/%Y")
    @todo = Todo.new
    @todos = Todo.where('user_id=?', current_user.id)
                 .where('due_date=?', params['d'])
                 .order('position')
    session[:path] = session[:working_date]
  end


  def todo_params
    params.require(:todo).permit(:subject, :due_date, :is_complete, :recurrence, :id, :user_id)
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end


  def determine_todos_as_determined_by_working_date
    b = session[:working_date].split('/')
    s = b[2] + '-' + b[0] + '-' + b[1]
    d = s.to_date

    # as default fall to /today
    todos = Todo.where('user_id=?', current_user.id)
                .where('due_date=?', d)
                .order('is_complete desc').order('position')
    
    # determine which day's todos to return
    if session[:working_date] == Date.today.strftime("%m/%d/%Y")
      todos =  Todo.where('user_id=?', current_user.id)
                   .where('(is_complete is null and due_date<?) or (due_date=?)', Date.today, Date.today)
                   .order('is_complete desc').order('position')
    elsif session[:working_date] == Date.tomorrow.strftime("%m/%d/%Y")
      todos = Todo.where('user_id=?', current_user.id)
                  .where('due_date=?', Date.today+1)
                  .order('is_complete desc').order('position')
    end
    return todos
  end


  def fix_date_format(raw_date_string)
    date_buffer = raw_date_string.split('/')
    return date_buffer[2] + '-' + date_buffer[0] + '-' + date_buffer[1]
  end


  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "You have to be a registered user to do that. It's easy to <a href='/signup' style='color:black;'>join</a>!"
      redirect_to login_url
    end
  end


  def get_path_in_context
    p = todos_path + "?d=" + fix_date_format(session[:working_date])

    if session[:working_date] == Date.today.strftime("%m/%d/%Y")
      p = today_path
      session[:path] = 'Today'
    end

    if session[:working_date] == Date.tomorrow.strftime("%m/%d/%Y")
      p = tomorrow_path
      session[:path] = 'Tomorrow'
    end

    return p
  end


end
