Entity = {}
Entity.__index = Entity

function Entity.new(value)
  local o = {}
  o._value = value or 0
  o._on_value_changed = {}
  setmetatable(o, Entity)
  return o
end

function Entity:add_value_changed_event_handler(handler)
  self._on_value_changed[handler] = handler
end

function Entity:remove_value_changed_event_handler(handler)
  self._on_value_changed[handler] = nil
end

function Entity:get_value()
  return self._value
end

function Entity:set_value(value)
  self._value = value
  for _, handler in pairs(self._on_value_changed) do
    handler(self._value)
  end
end


local entity = Entity.new()

entity:add_value_changed_event_handler(function(value)
  print("value changed: " .. value)
end)

local handler
handler = function(value)
  print("changed first!")
  entity:remove_value_changed_event_handler(handler)
end
entity:add_value_changed_event_handler(handler)

entity:set_value(2)
entity:set_value(3)

