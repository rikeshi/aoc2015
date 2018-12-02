# import Base: hash, isequal
#
# struct Tup
#   x::Int32
#   y::Int32
# end
#
# # implement isequal and hash for Tup to enable use as keys in Dict
# function Base.isequal(A::Tup, B::Tup)
#   A.a == B.a && A.b == B.b
# end
#
# function Base.hash(A::Tup)
#   hash(string(A.a, A.b))
# end

visited = Dict((0, 0) => 1)
x = 0
y = 0

for ch in open(f->read(f, String), "input")
  global x, y

  if ch == '^'
    y += 1
  elseif ch == 'v'
    y -= 1
  elseif ch == '>'
    x += 1
  elseif ch == '<'
    x -= 1
  end

  co = (x, y)
  visited[co] = get(visited, co, 0) + 1
end

println(length(visited))
