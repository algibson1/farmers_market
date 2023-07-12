# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


@scarlet = Farm.create!(name: "Scarlet Orchards", pick_your_own: true, acres: 354)
    @red_d = @scarlet.products.create!(name: "Red Delicious Apple", fruit: true, seeds: true, cost_per_pound: 1.21)
    @lady = @scarlet.products.create!(name: "Pink Lady Apple", fruit: true, seeds: true, cost_per_pound: 1.76)
    @braeburn = @scarlet.products.create!(name: "Braeburn Apple", fruit: true, seeds: true, cost_per_pound: 1.71)
    @gold = Farm.create!(name: "Golden Orchards", pick_your_own: true, acres: 765)
    @golden_d = @gold.products.create!(name: "Golden Delicious Apple", fruit: true, seeds: true, cost_per_pound: 1.11)
    @lilac = Farm.create!(name: "Lilac Vineyard", pick_your_own: false, acres: 234)
    @concord = @lilac.products.create!(name: "Concord Grape", fruit: true, seeds: false, cost_per_pound: 1.89)
    @valerie = Farm.create!(name: "Valerie's Veggies", pick_your_own: false, acres: 654)
    @romanesco = @valerie.products.create!(name: "Romanesco Broccoli", fruit: false, seeds: false, cost_per_pound: 4.32)