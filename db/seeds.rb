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
  puts "Destroying all cocktail  seeds"
  puts "Starting cocktail seed"
  Cocktail.destroy_all

    file = open("https://www.allrecipes.com/search/?wt=cocktail").read
    nokogiri_object = Nokogiri::HTML(file)
    cards = nokogiri_object.search('.fixed-recipe-card')[0..40]
    cards.each do |card|
      title = card.search("span.fixed-recipe-card__title-link").text
      description = card.search(".fixed-recipe-card__description").text
      image = card.search(".fixed-recipe-card__img").attr('data-original-src').value
      ratings = card.at_css("span.stars")['data-ratingstars'].to_f.round(1)
      url = open(card.at_css("a")['href']).read
      nokogiri_object_two = Nokogiri::HTML(url)
      time = nokogiri_object_two.search("div.recipe-meta-item-body")
      final_time = time.first.text.strip

      allecipe = [title, description, ratings, final_time, image]
      cocktail = Cocktail.new(name: title, description: description, difficulty: %w(easy medium hard).sample, image: image)
      cocktail.save
      puts "#{cocktail.name} was added to the db"
    end

end
