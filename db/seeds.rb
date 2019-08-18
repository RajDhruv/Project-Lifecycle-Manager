# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

11.times do |index|
	User.create(email:"user_#{index+1}@example.com",name:"user_#{index+1}",password:"123456",password_confirmation:"123456", roles:"developer")
end

dhruv=User.create(email:"rajdhruv30@gmail.com",name:"Dhruv Raj",password:"pleomaxX1!",password_confirmation:"pleomaxX1!",roles:"admin")
puts "Dhruv Created"

dhruv_project1 = Project.create(name:"Dhruv Project 1",description:"Description of Seed First Project",admin:dhruv, lock_version:1, developer_count:0)
puts "Dhruv Project 1 Created"

dhruv_project2 = Project.create(name:"Dhruv Project 2",description:"Description of Seed Second Project",admin:dhruv, lock_version:1, developer_count:0)
puts "Dhruv Project 2 Created"

User.first(6).each do |user|
	dhruv_project1.users<<user
end
puts "First 6 Users Mapped to First Project"

dhruv_project1.update_attribute("developer_count",6)

(User.last(5)-User.last(1)).each do |user|
	dhruv_project2.users<<user
end
puts "Last 4 Users Mapped to Second Project"

dhruv_project2.update_attribute("developer_count",4)

all_user_ids=User.all.map(&:id)
first_six=all_user_ids[1..6]
last_six=all_user_ids[7..10]

rand(18..23).times do |i|
	user_id=first_six.sample
	status=rand(0..2)
	Task.create(description:"Project 1 Tasks Description",lock_version:1,user_id:user_id,project:dhruv_project1,status:status)
end
puts "Project 1 Task Allocation Completed"

rand(18..23).times do |i|
	user_id=last_six.sample
	status=rand(0..2)
	Task.create(description:"Project 1 Tasks Description",lock_version:1,user_id:user_id,project:dhruv_project2,status:status)
end
puts "Project 2 Task Allocation Completed"