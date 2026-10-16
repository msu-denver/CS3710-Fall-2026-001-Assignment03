Student.destroy_all
Section.destroy_all
Semester.destroy_all
Course.destroy_all

[ "Spring 2027", "Summer 2027", "Fall 2027", "Spring 2028" ].each do |sem|
  Semester.create!(which: sem)
end

[ "CS3700", "CS3210", "CS3710", "CS3250" ].each do |course|
  Course.create!(name: course)
end

10.times do
  Section.create!(
    course: Course.all.sample,
    semester: Semester.all.sample,
    number: rand(1..4)
  )
end

first_names = [ "Ada", "Alan", "Grace", "Linus", "Barbara", "Dennis", "Margaret", "Ken", "Radia", "Tim" ]
last_names = [ "Lovelace", "Turing", "Hopper", "Torvalds", "Liskov", "Ritchie", "Hamilton", "Thompson", "Perlman", "Lee" ]

20.times do |i|
  Student.create!(
    first_name: first_names[i % 10],
    last_name: last_names[(i * 3) % 10],
    student_number: 900_000_001 + i,
    phone: format("303-555-%04d", i + 1)
  )
end

Section.all.each do |section|
  section.students << Student.all.sample(5)
end
