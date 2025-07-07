# Clear all old data
SessionMetric.delete_all
TrainingSession.delete_all
Athlete.delete_all

athletes = [
  { name: "Steve Roger", position: "MF", number: 8, email: "steve@example.com" },
  { name: "Tony Stark", position: "FW", number: 9, email: "tony@example.com" },
  { name: "Bruce Banner", position: "DF", number: 5, email: "bruce@example.com" },
  { name: "Natasha Romanoff", position: "MF", number: 6, email: "natasha@example.com" },
  { name: "Clint Barton", position: "FW", number: 7, email: "clint@example.com" },
  { name: "Peter Parker", position: "MF", number: 10, email: "peter@example.com" },
  { name: "T'Challa", position: "DF", number: 4, email: "tchalla@example.com" },
  { name: "Stephen Strange", position: "MF", number: 11, email: "strange@example.com" },
  { name: "Scott Lang", position: "FW", number: 12, email: "scott@example.com" },
  { name: "Sam Wilson", position: "DF", number: 3, email: "sam@example.com" }
]

created_athletes = athletes.map do |data|
  Athlete.create!(
    name: data[:name],
    position: data[:position],
    number: data[:number],
    email: data[:email],
    password: "password",
    password_confirmation: "password"
  )
end

sessions = [
  { name: "Speed Drill", date: Date.today - 7, duration: 90 },
  { name: "Agility Training", date: Date.today - 5, duration: 75 },
  { name: "Tactical Play", date: Date.today - 3, duration: 105 }
]

created_sessions = sessions.map do |session|
  TrainingSession.create!(session)
end

created_athletes.each do |athlete|
  created_sessions.each do |session|
    SessionMetric.create!(
      training_session: session,
      athlete: athlete,
      distance: rand(5000..10000),
      sprints: rand(5..20),
      top_speed: rand(20.0..35.0).round(2)
    )
  end
end

puts "✅ Seed complete: 10 real athletes, 3 real sessions, metrics for each"
