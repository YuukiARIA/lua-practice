local function cls()
  io.write("\x1B[2J")
end

local State = {
  None = 0,
  Black = 1,
  White = 2
}

local Reversi = {}

function Reversi.new(size)
  local o = {
    _size = size,
    _field = {}
  }
  setmetatable(o, { __index = Reversi })
  o:initialize(size)
  return o
end

function Reversi:initialize(size)
  self._field = {}
  for j = 1, self._size do
    local row = {}
    for i = 1, self._size do
      row[i] = State.None
    end
    self._field[j] = row
  end

  self:set_state(4, 4, State.Black)
  self:set_state(5, 4, State.White)
  self:set_state(4, 5, State.White)
  self:set_state(5, 5, State.Black)
end

function Reversi:is_valid(i, j)
  return 1 <= i and i <= self._size and 1 <= j and j <= self._size
end

function Reversi:is_empty(i, j)
  return self:get_state(i, j) == State.None
end

function Reversi:get_state(i, j)
  return self._field[j][i]
end

function Reversi:set_state(i, j, state)
  self._field[j][i] = state
end

function Reversi:get_opposite(stone)
  if stone == State.Black then
    return State.White
  elseif stone == State.White then
    return State.Black
  end
  return State.None
end

function Reversi:print()
  io.write("  ")
  for i = 1, #self._field[1] do
    io.write(string.format(" %d ", i))
  end
  print()

  for j = 1, #self._field do
    local row = self._field[j]
    io.write(string.format("%d ", j))
    for i = 1, #row do
      local state = row[i]
      if state == State.None then
        io.write(" . ")
      elseif state == State.Black then
        io.write(" X ")
      else
        io.write(" O ")
      end
    end
    print()
  end
end

function Reversi:iterate_reversible_stones(stone, i, j, di, dj, func)
  if not self:is_valid(i, j) then
    return false
  end
  local s = self:get_state(i, j)
  if s == State.None then
    return false
  elseif s == stone then
    return true
  elseif s == self:get_opposite(stone) then
    if self:iterate_reversible_stones(stone, i + di, j + dj, di, dj, func) then
      func(i, j)
      return true
    end
  end

  return false
end

function Reversi:iterate_reversible_neighbors(stone, i, j, func)
  for dj = -1, 1 do
    for di = -1, 1 do
      if di ~= 0 or dj ~= 0 then
        self:iterate_reversible_stones(stone, i + di, j + dj, di, dj, func)
      end
    end
  end
end

function Reversi:count_reversible_neighbors(stone, i, j)
  local count = 0
  self:iterate_reversible_neighbors(stone, i, j, function(_, _)
    count = count + 1
  end)
  return count
end

function Reversi:reverse_reversible_neighbors(stone, i, j)
  self:iterate_reversible_neighbors(stone, i, j, function(ii, jj)
    self:reverse(ii, jj)
  end)
end

function Reversi:reverse(i, j)
  local s = self:get_state(i, j)
  if s ~= State.None then
    self:set_state(i, j, self:get_opposite(s))
  end
end

function Reversi:is_puttable(i, j, stone)
  return self:is_valid(i, j) and self:get_state(i, j) == State.None and self:count_reversible_neighbors(stone, i, j) > 0
end

function Reversi:put(i, j, stone)
  if self:is_puttable(i, j, stone) then
    self:set_state(i, j, stone)
    self:reverse_reversible_neighbors(stone, i, j)
    return true
  end
  return false
end

local reversi = Reversi.new(8)
reversi:print()
reversi:put(6, 4, State.Black)
reversi:print()
reversi:put(4, 3, State.White)
reversi:print()
reversi:put(3, 4, State.Black)
reversi:print()
