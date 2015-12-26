puts "Generating departments..."
number_of_departments = 100
Department.delete_all
bosses_ids = []
data = number_of_departments .times.with_index.map do |i|
  {
    id: i + 1,
    name: Faker::Commerce.department(2)
  }
end
Department.create(data)

puts "Generating employees..."
Employee.delete_all
timestamp = 15.minutes.ago
data = 20000.times.map do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{last_name.downcase}@#{Faker::Internet.email.split("@").last}"
  {
    department_id: rand(number_of_departments) + 1,
    name: [first_name, last_name].join(" "),
    email: email,
    birthdate: (rand(40*365) + 18*365).days.ago.to_date,
    salary: (rand(10)+1)*1000,
    remote: rand > 0.8,
    created_at: timestamp,
    updated_at: timestamp
  }
end
Employee.create(data)

puts "Generating bosses..."
number_of_bosses = 100
Boss.delete_all
bosses_ids = []
data = number_of_bosses.times.with_index.map do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{last_name.downcase}@#{Faker::Internet.email.split("@").last}"
  {
    id: i + 1,
    :name => [first_name, last_name].join(" "),
    :email => email,
    :salary => (rand(10)+1)*10000
  }
end
Boss.create(data)

puts "Generating clerks..."
Clerk.delete_all
timestamp = 15.minutes.ago
data = 2000.times.map do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{last_name.downcase}@#{Faker::Internet.email.split("@").last}"
  {
    :boss_id => rand(number_of_bosses) + 1,
    :name => [first_name, last_name].join(" "),
    :email => email,
    :salary => (rand(10)+1)*1000,
    :subject_to_lay_off => rand > 0.8,
    :created_at => timestamp,
    :updated_at => timestamp
  }
end
Clerk.create(data)

puts "Generating files..."
FileRecord.delete_all
ids = []
2000.times do |t|
  file = FileRecord.create({
    name: "file-#{t}",
    size: rand(100000),
    parent_id: ids.sample
  })

  ids << file.id
end

puts "Updating File tree leaf statuses..."
FileRecord.all.each do |r|
  r.update_attribute(:leaf, r.children.empty?)
end
