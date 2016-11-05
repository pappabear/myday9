class Todo < ActiveRecord::Base


  validates_presence_of :subject

  before_validation :convert_due_date, :on => [:create, :update]

  has_one :user


  def is_late?
    o = false

    if self.due_date.nil?
      return
    end

    if self.due_date < Date.today()
      if !self.is_complete?
        o = true
      end
    end

    return o
  end


  private


  def description
    s = ""
    s += "Late. " if self.is_late?
    s += "Due " + self.due_date.to_s + ". "
    s += "Doesn't recur." if self.recurrence==0
    s += "Recurs daily." if self.recurrence==1
    s += "Recurs weekly." if self.recurrence==2
    s += "Recurs every 2 weeks." if self.recurrence==3
    return s
  end


  def convert_due_date

    if self.due_date_before_type_cast.to_s == ""
      return
    end

    if self.due_date_before_type_cast.nil?
      return
    end

    if self.due_date_before_type_cast.to_s.split('-').count == 3
      # date is already in yyyy-mm-dd format
      return
    end

    parts = self.due_date_before_type_cast.split('/')
    self.due_date = parts[2] + '-' + parts[0] + '-' + parts[1]

  end


end
