function lookandsay(str, ntimes)
  old = [c for c in str]
  new = []
  for _ in 1:ntimes
    count = 1
    for i in 1:length(old)
      if old[i] == try old[i+1] catch; "" end
        count += 1
      else
        append!(new, [Char(count + 48), old[i]])
        count = 1
      end
    end
    old, new = new, old
    resize!(new, 0)
  end
  length(old)
end

input = "1113122113"
println(lookandsay(input, 40))
println(lookandsay(input, 50))
