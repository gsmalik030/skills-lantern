User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password')

20.times do
    Course.create(
        title: Faker::Educator.course_name,
        description: Faker::TvShows::GameOfThrones.quote,
        user_id: User.first.id
    )
end