function count_characters(fname)
  sum_original = sum_encoded = 0
  for line in eachline(fname)
    sum_original += length(line)
    sum_encoded += 6
    i = 2
    while i < length(line)
      if line[i] == '\\' || line[i] == '"'
        sum_encoded += 2
      else
        sum_encoded += 1
      end
      i += 1
    end
  end
  sum_encoded - sum_original
end

println(count_characters("input"))

