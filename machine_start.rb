system('clear')
puts
puts ('*'*80)
puts "Starting   BOILERPLATE   in a Docker container..."
puts ('*'*80)
puts

puts ('-'*80)
print "Waiting for the database engine to startup..."
sleep(10)
puts " done."
puts ('-'*80)

puts

puts ('-'*80)
puts 'Creating the database and running migrations...'
puts ('-'*80)
system("rake  db:create")
system("rake  db:migrate")
puts '   Done.' 
puts

puts ('-'*80)
puts 'Seeding the database...'
puts ('-'*80)
system("rake  db:seed")
puts '    Done.'
puts

puts ('-'*80)
puts 'Launch... the app server.  Enjoy!'
puts ('-'*80)
system("rails s -p 3000 -b 0.0.0.0")
puts

system("sudo rm tmp/pids/server.pid")

