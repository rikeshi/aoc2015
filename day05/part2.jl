total = 0

for line in eachline("input")
  global total
  doublepair = false
  withgap = false
  pairs = Dict{String, UInt}()

  for i in eachindex(line)
    if !doublepair && i > 1
      pair = line[i-1:i]
      if haskey(pairs, pair)
        if pairs[pair] != i-1
          doublepair = true
        end
      else
        pairs[pair] = i
      end
    end

    if !withgap && i > 2
      if line[i-2] == line[i]
        withgap = true
      end
    end
  end

  if doublepair && withgap
    total +=1
  end
end

println(total)
