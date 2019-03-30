Player = {}

function Player.new(name)
  local player = {
    _name = name
  }
  setmetatable(player, { __index = Player })
  return player
end

function Player:get_name() -- same as `Player.get_name(self)`
  return self._name
end

local player = Player.new("alice")
print(player:get_name()) -- same as `player.get_name(player)`
