require 'json'
require './code.rb'

grid = JSON.parse(ARGV[0])

result = max_distance(grid)

p result