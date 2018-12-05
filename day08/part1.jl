function count_characters(fname)
  sum_code = sum_memory = 0
  for line in eachline(fname)
    sum_code += length(line)
    escaped = false
    i = 1
    while i <= length(line)
      if escaped
        if line[i] == 'x'
          sum_memory += 1
          i += 2
        else
          sum_memory += 1
        end
        escaped = false
      elseif line[i] == '\\'
        escaped = true
      elseif line[i] != '"'
        sum_memory += 1
      end
      i += 1
    end
  end
  sum_code - sum_memory
end

println(count_characters("input"))

