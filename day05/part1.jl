total = 0

for line in eachline("input")
  global total
  vowelcount = 0
  hasdup = false
  valid = true

  for i in eachindex(line)
    if i != 1
      if line[i-1] == 'a' && line[i] == 'b' ||
         line[i-1] == 'c' && line[i] == 'd' ||
         line[i-1] == 'p' && line[i] == 'q' ||
         line[i-1] == 'x' && line[i] == 'y'
        valid = false
        break
      end

      if line[i-1] == line[i]
        hasdup = true
      end
    end

    if line[i] in "aeiou"
      vowelcount += 1
    end
  end

  if valid && vowelcount >= 3 && hasdup
    total += 1
  end
end

println(total)
