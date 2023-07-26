User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password')

60.times do
    Course.create(
        title: Faker::Educator.course_name,
        description: Faker::TvShows::GameOfThrones.quote,
        user_id: User.first.id,
        short_description: Faker::TvShows::GameOfThrones.quote,
        language: "English",
        level: "Beginner",
        price: 20.00
    )
end