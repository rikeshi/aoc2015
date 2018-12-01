floor = 0
position = 0

for ch in open(f->read(f, String), "input")
  global floor
  global position

  if ch == '('
    floor += 1
  elseif ch == ')'
    floor -= 1
  end

  position += 1

  if floor < 0
    break
  end
end

println(position)
