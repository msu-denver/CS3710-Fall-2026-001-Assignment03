# CS3710-Fall-2026-001-Assignment03

## Your name

## Your student number

## Description

In this assignment, you'll extend your Assignment 2 classroom management
system. Start by copying your Assignment 2 application into this repo
(keep this README, `db/seeds.rb`, and `.github/`).

### Students

Add students with these fields:

- `first_name`
- `last_name`
- `student_number` (the student's 900 number; Rails already uses `id`)
- `phone`

A student has many sections, and a section has many students. You may use
either `has_many :through` (with a join model) or
`has_and_belongs_to_many`.

### Validations

Each model must validate its fields:

- Student: `first_name` and `last_name` are 2 to 20 characters;
  `student_number` is unique and between 900000000 and 999999999;
  `phone` is unique.
- Course: `name` is two capital letters followed by four digits, e.g.
  `CS3710`.
- Semester: `which` is `Spring`, `Summer`, or `Fall`, a space, and a year,
  e.g. `Fall 2027`.

Write at least one test for each validation (seven or more tests) in
`test/models/`. Test both a value that should be accepted and one that
shouldn't.

### Deleting

- When a student is removed, remove them from all their sections.
- When a course is removed, remove all its sections.
- When a section is removed, don't remove its course or its students.

### Searching

Add a search form to these index pages:

- Semesters: search `which`
- Courses: search `name`
- Students: search `student_number`

A search should match part of the value, e.g. `fall` finds `Fall 2027`.
Build the query with a placeholder (`where("name LIKE ?", ...)`), never by
putting the search text into the SQL string yourself; Brakeman checks for
SQL injection.

### Conventions from Assignment 2

- No foreign keys displayed
- Appropriate drop-downs, and check boxes for choosing a student's
  sections
- When showing a semester or a course, show all associated sections
- When showing a section, show its students; when showing a student,
  show their sections

### Seeds

Use the `db/seeds.rb` file in this repo. Note the semesters are now
written `Spring 2027`, not `2027 Spring`. After `db:migrate`, run
`db:seed`.

```ruby
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
```

### Tests

Once you add validations, the generated tests will fail until you fix
them:

- The fixtures in `test/fixtures/` must be valid. Give the two students
  different student numbers and phones, and give courses and semesters
  names that pass your validations.
- The generated "should create student" test posts the fixture's student
  number and phone, which are already taken. Post new ones.

`rails test` must pass with no failures or errors, and with at least
35 runs and 51 assertions (the scaffold tests plus your validation tests).
GitHub Actions also runs RuboCop (Rails omakase style), Brakeman, and
bundler-audit; static analysis is 20% of the grade.

## Sources used, including AI prompts.
