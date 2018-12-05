struct Mapping
  v2i::Dict{String, Int}
  i2v::Array{String}

  function Mapping()
    new(Dict(), [])
  end
end

function set_or_get_mapping(mapping, name)
  if !haskey(mapping.v2i, name)
    push!(mapping.i2v, name)
    mapping.v2i[name] = length(mapping.i2v)
  end
  return mapping.v2i[name]
end

function adjacency_matrix(distances, mapping)
  mat = zeros(length(mapping.i2v), length(mapping.i2v))
  for d in distances
    i, j, distance = d
    mat[i, j] = distance
    mat[j, i] = distance
  end
  mat
end

function read_input(fname)
  mapping = Mapping()
  distances = []
  for line in eachline(fname)
    from, _, to, _, distance = split(line)
    distance = parse(Int, distance)
    i = set_or_get_mapping(mapping, from)
    j = set_or_get_mapping(mapping, to)
    push!(distances, (i, j, distance))
  end
  distances, mapping
end

function pretty_print(matrix)
  len = size(matrix)[1]
  for i in 1:len
    for j in 1:len
      if matrix[i, j] <  10 print(' ') end
      if matrix[i, j] < 100 print(' ') end
      print(matrix[i, j], " ")
    end
    println()
  end
end

function tsp(matrix, visited = [])
  remaining = setdiff(1:size(matrix)[1], visited)
  if length(remaining) == 1
    return matrix[visited[end], remaining[1]]
  end
  maximum(
    (length(visited) != 0
      ? matrix[visited[end], to]
      : 0)
    + tsp(matrix, [visited; to])
    for to in remaining)
end


distances, mapping = read_input("input")
matrix = adjacency_matrix(distances, mapping)
#pretty_print(matrix)
shortest_route = tsp(matrix)
println(shortest_route)
