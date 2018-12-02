total = 0

for line in eachline("input")
  global total

  #dims = map(x->parse(UInt32, x), split(line, 'x'))
  dims = [parse(UInt32,x) for x in split(line, 'x')]

  c = prod(dims)
  a, i = findmin(dims)
  dims[i] = typemax(UInt32)
  b = minimum(dims)

  total += a + a + b + b + c
end

println(total)

