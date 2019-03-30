memo = {}

function fib(n)
  if not memo[n] then
    local v
    if n == 0 then
      v = 0
    elseif n == 1 then
      v = 1
    else
      v = fib(n - 2) + fib(n - 1)
    end
    memo[n] = v
  end
  return memo[n]
end

print(fib(35)) --> 9227465
