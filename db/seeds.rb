# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Limpando dados antigos..."
Customer.destroy_all
Package.destroy_all
Plan.destroy_all
AdditionalService.destroy_all

puts "Criando Planos..."
basic = Plan.create!(name: "Essencial", price: 49.90)
advanced = Plan.create!(name: "Avançado", price: 79.90)
premium = Plan.create!(name: "Premium", price: 129.90)

puts "Criando Serviços Adicionais..."
hbo = AdditionalService.create!(name: "HBO Max", price: 19.90)
premiere = AdditionalService.create!(name: "Premiere FC", price: 29.90)
telecine = AdditionalService.create!(name: "Telecine", price: 24.90)
discovery = AdditionalService.create!(name: "Discovery Kids", price: 14.90)

puts "Criando Pacotes..."
family = Package.create!(
  name: "Família",
  price: 99.90,
  plan: basic,
  additional_services: [discovery]
)

sports = Package.create!(
  name: "Esportes",
  price: 119.90,
  plan: advanced,
  additional_services: [premiere]
)

cinema = Package.create!(
  name: "Cinema",
  price: 139.90,
  plan: premium,
  additional_services: [hbo, telecine]
)

puts "Criando Clientes..."
10.times do
  Customer.create!(
    name: Faker::Name.name,
    age: Faker::Number.between(from: 18, to: 65)
  )
end

puts "Seed finalizada com sucesso"
