Vector3 = {}
Vector3.__index = Vector3

function Vector3.new(x, y, z)
  local v = {
    x = x,
    y = y,
    z = z
  }
  setmetatable(v, Vector3)
  return v
end

function Vector3.__add(a, b)
  return Vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

function Vector3:dot(v)
  return self.x * v.x + self.y * v.y + self.z * v.z
end

function Vector3:magnitudeSqr()
  return self:dot(self)
end

function Vector3:magnitude()
  return math.sqrt(self:magnitudeSqr())
end

function Vector3:normalized()
  local len = self:magnitude()
  return Vector3.new(self.x / len, self.y / len, self.z / len)
end

function Vector3:print()
  print(string.format("(%f, %f, %f)", self.x, self.y, self.z))
end

local a = Vector3.new(1, 2, 3)
local b = Vector3.new(4, 5, 6)

a:print()

local c = (a + b):normalized()
c:print()
