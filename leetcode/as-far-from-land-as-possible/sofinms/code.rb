# @param {Integer[][]} grid
# @return {Integer}
def max_distance(grid)
    @minimum_land_distances = {}
    iteration = 0
    coords = get_all_lands grid
    while coords.length > 0
        iteration += 1
        coords = get_next_level_coords coords, grid
    end
    iteration = 0 if iteration == 1 
    iteration - 1
end

def get_next_level_coords current_coords, grid
    next_coords = []
    current_coords.each do |coord|
        current_coords_distance = is_coords_in_distance coord
        current_coords_distance = 0 if current_coords_distance.nil?
        water_neighbors = get_water_neighbors coord, grid
        water_neighbors.each do |coords|
            if !is_coords_in_distance coords
                set_distance(coords, current_coords_distance+1)
                next_coords.push(coords)
            end
        end
    end
    next_coords
end

def get_all_lands(grid)
    arr = []
    (0..grid.length-1).to_a.each do |row|
        (0..grid[row].length-1).to_a.each do |column|
            if grid[row][column] == 1
                arr.push([row, column])
            end
        end
    end
    arr
end

def is_coords_in_distance coords
    row = coords[0]
    column = coords[1]
    @minimum_land_distances["#{row.to_s}_#{column.to_s}".to_sym]
end

def set_distance coords, distance
    row = coords[0]
    column = coords[1]
    @minimum_land_distances["#{row.to_s}_#{column.to_s}".to_sym] = distance
end

def get_water_neighbors coords, grid
    row = coords[0]
    column = coords[1]
    water_neighbors = []
    [[row-1, column], [row, column+1], [row+1, column], [row, column-1]].each do |cell|
        if cell[0] >= 0 && cell[1] >= 0 && grid[cell[0]] && grid[cell[0]][cell[1]] && grid[cell[0]][cell[1]] == 0
            water_neighbors.push(cell)
        end
    end
    return water_neighbors
end