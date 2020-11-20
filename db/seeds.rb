# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'
require 'nokogiri'


if Rails.env.development?

  puts "Destroying all Ingredients the seeds"
  puts "Starting ingredient seed"
  Ingredient.destroy_all
  url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
  ingredients_serialized = open(url).read
  ingredients = JSON.parse(ingredients_serialized)

  ingredients["drinks"].each do |ingredient|
    ingredient = Ingredient.new(name: ingredient.values[0])
    ingredient.save
    p "#{ingredient.name} has been created"
  end

  # puts "Destroying all cocktail  seeds"
  # puts "Starting cocktail seed"
  # Cocktail.destroy_all

  #   url = 'https://tuxedono2.com/recipes/'
  #   direct_website = open(url).read
  #   nokogiri_object = Nokogiri::HTML(direct_website)

  #   cocktail_card = nokogiri_object.search(".recipe_admin_element")[0]

  #   cocktail_card.each do |card|
  #     image = card.search(".element-image").attr("src").value.gsub("100x100","600x400")
  #     file = URI.open(image)
  #     title = card.search(".index-element-name").text
  #     description = card.search(".subtext").text.strip.gsub("\n",", ")

  #     cocktail = Cocktail.new(name: title, description: description, difficulty: %w(easy medium hard).sample, image: image)
  #     cocktail.photo.attach(io: file, filename: "#{cocktail.name}.jpg", content_type: 'image/png')
  #     cocktail.save
  #     puts "#{cocktail.name} was added to the db"
  #   end

end
