math.randomseed(os.time())

width = 30
height = 30

map = {}
for j = 1, height - 1 do
  local row = {}
  for i = 1, width - 1 do
    row[i] = math.random() < 0.2
  end
  map[j] = row
end

function printMap(map)
  io.write("\x1B[2J")
  for j = 1, #map do
    local row = map[j]
    for i = 1, #row do
      if row[i] then
        io.write("*")
      else
	io.write(" ")
      end
    end
    print("")
  end
end

function countNeighbors(map, x, y)
  local count = 0
  for j = -1, 1 do
    local ny = y + j
    if 1 <= ny and ny <= #map then
      local row = map[ny]
      for i = -1, 1 do
        local nx = x + i
	if 1 <= nx and nx <= #row then
          if (nx ~= x or ny ~= y) and row[nx] then
	    count = count + 1
          end
	end
      end
    end
  end
  return count
end

function step(map)
  local newMap = {}
  for j = 1, #map do
    local row = map[j]
    local newRow = {}
    for i = 1, #row do
      local count = countNeighbors(map, i, j)
      newRow[i] = (row[i] and (count == 2 or count == 3)) or (not row[i] and count == 3)
    end
    newMap[j] = newRow
  end
  return newMap
end

while true do
  printMap(map)
  io.read("*l")
  map = step(map)
end
