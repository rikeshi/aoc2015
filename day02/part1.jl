total = 0

for line in eachline("input")
  global total

  #dims = map(x->parse(UInt32, x), split(line, 'x'))
  dims = [parse(UInt32,x) for x in split(line, 'x')]

  l = dims[1]
  w = dims[2]
  h = dims[3]

  sides = [l*w, w*h,  h*l]
  total += 2 * sum(sides) + minimum(sides)
end

println(total)
