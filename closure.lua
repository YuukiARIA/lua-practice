function create_closure()
  local count = 0
  return function()
    count = count + 1
    return count
  end
end

local c1 = create_closure()
local c2 = create_closure()

print("c1 = " .. c1()) --> c1 = 1
print("c2 = " .. c2()) --> c2 = 1
print("c1 = " .. c1()) --> c1 = 2
print("c2 = " .. c2()) --> c2 = 2
print("c2 = " .. c2()) --> c2 = 3
print("c1 = " .. c1()) --> c1 = 3
