Todo.destroy_all
User.destroy_all

# Users

puts 'Creating users...'

User.create!(name:  "Chip Irek",
             email: "chip.irek@gmail.com",
             password:              "lollip0p",
             password_confirmation: "lollip0p",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

puts "Creating todos..."

Todo.create(:subject=>"CIO / InfoWorld",:due_date=>"2017-1-8",:recurrence=>2, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"1pm staff meeting",:due_date=>"2017-01-10",:recurrence=>2, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"create action plan on feedback from my approach slides",:due_date=>"2017-01-07",:recurrence=>0, :position=>3, :user_id=>User.first.id)
Todo.create(:subject=>"Read 'Building Real-World Cloud Apps with Azure'",:due_date=>"2017-01-07",:recurrence=>0, :position=>14, :user_id=>User.first.id)
Todo.create(:subject=>"re-start MyDay in .NET with new architecture",:due_date=>"2017-01-07",:recurrence=>0, :position=>15, :user_id=>User.first.id)
Todo.create(:subject=>"get Salmon Oil for Molly from a vet",:due_date=>"2017-01-07",:recurrence=>0, :position=>17, :user_id=>User.first.id)
Todo.create(:subject=>"MyDay9-RoR - test and identify remaining work",:due_date=>"2017-01-07",:recurrence=>0, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"730am take Molly to doggie daycare",:due_date=>"2017-01-11",:recurrence=>2, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"print Guardian dental form",:due_date=>"2017-01-09",:recurrence=>0, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"440pm dentist",:due_date=>"2017-01-09",:recurrence=>0, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"out: return roku",:due_date=>"2017-01-07",:recurrence=>0, :position=>5, :user_id=>User.first.id)
Todo.create(:subject=>"bath for Molly",:due_date=>"2017-01-07",:recurrence=>0, :position=>16, :user_id=>User.first.id)
Todo.create(:subject=>"out: groceries",:due_date=>"2017-01-07",:recurrence=>0, :position=>9, :user_id=>User.first.id)
Todo.create(:subject=>"squish",:due_date=>"2017-01-08",:recurrence=>2, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"mangle",:due_date=>"2017-01-08",:recurrence=>3, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"clean apartment",:due_date=>"2017-01-13",:recurrence=>2, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"put together game pc",:due_date=>"2017-01-07",:recurrence=>0, :position=>10, :user_id=>User.first.id)
Todo.create(:subject=>"trim dog nails",:due_date=>"2017-01-07",:recurrence=>0, :position=>11, :user_id=>User.first.id)
Todo.create(:subject=>"Rosetta Stone",:due_date=>"2017-01-07",:recurrence=>1, :position=>12, :user_id=>User.first.id)
Todo.create(:subject=>"out: mangle",:due_date=>"2017-01-07",:recurrence=>0, :position=>6, :user_id=>User.first.id)
Todo.create(:subject=>"out: skate sharpening",:due_date=>"2017-01-07",:recurrence=>0, :position=>7, :user_id=>User.first.id)
Todo.create(:subject=>"out: buy exercise equipment",:due_date=>"2017-01-07",:recurrence=>0, :position=>8, :user_id=>User.first.id)
Todo.create(:subject=>"8am Exec Team catch-up",:due_date=>"2017-01-12",:recurrence=>2, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"drycleaning",:due_date=>"2017-01-07",:recurrence=>0, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"long walk for Molly",:due_date=>"2017-01-07",:recurrence=>2, :position=>13, :user_id=>User.first.id)
Todo.create(:subject=>"1145am Severyn skate",:due_date=>"2017-01-13",:recurrence=>2, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"long walk for Molly",:due_date=>"2017-01-08",:recurrence=>2, :position=>1, :user_id=>User.first.id)
Todo.create(:subject=>"catch-up email",:due_date=>"2017-01-08",:recurrence=>2, :position=>4, :user_id=>User.first.id)
Todo.create(:subject=>"6am exercise",:due_date=>"2017-01-07",:recurrence=>1, :position=>4, :user_id=>User.first.id)

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
