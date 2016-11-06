Todo.destroy_all
User.destroy_all

# Users

print 'Creating users...'

User.create!(name:  "Chip Irek",
             email: "chip.irek@gmail.com",
             password:              "lollip0p",
             password_confirmation: "lollip0p",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Todos

print 'Creating new todos...'

Todo.create(:subject=>'1 due today',:due_date=>Date.today,:recurrence=>0, :user_id=>User.first.id)
Todo.create(:subject=>'2 completed today',:due_date=>Date.today,:recurrence=>0, :is_complete=>true, :user_id=>User.first.id)
Todo.create(:subject=>'9 due yesterday',:due_date=>Time.now.to_date.advance(:days=>-1).advance(:hours=>-5).strftime("%m/%d/%Y"),:recurrence=>0, :user_id=>User.first.id)
Todo.create(:subject=>'due tomorrow',:due_date=>Date.tomorrow,:recurrence=>0, :user_id=>User.first.id)
Todo.create(:subject=>'item with NO due date',:due_date=>nil,:recurrence=>0, :user_id=>User.first.id)
Todo.create(:subject=>'daily recurrence',:due_date=>Date.today,:recurrence=>1, :user_id=>User.first.id)
Todo.create(:subject=>"Chip should NOT see Hartl's items #1",:due_date=>Date.today,:recurrence=>1, :user_id=>User.last.id)
Todo.create(:subject=>"Chip should NOT see Hartl's items #2",:due_date=>Date.tomorrow,:recurrence=>1, :user_id=>User.last.id)
sleep(2)
print 'done.'
puts 
