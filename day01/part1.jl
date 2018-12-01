floor = 0

for ch in open(f->read(f, String), "input")
  global floor
  if ch == '('
    floor += 1
  elseif ch == ')'
    floor -= 1
  end
end

println(floor)
