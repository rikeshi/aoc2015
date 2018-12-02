visited = Dict((0, 0) => 1)
x_santa = 0
y_santa = 0
x_robot = 0
y_robot = 0
i = 0

for ch in open(f->read(f, String), "input")
  global x_santa, y_santa, x_robot, y_robot, i

  if i & 1 == 1
    # santa's turn
    if ch == '^'
      y_santa += 1
    elseif ch == 'v'
      y_santa -= 1
    elseif ch == '>'
      x_santa += 1
    elseif ch == '<'
      x_santa -= 1
    end

    co = (x_santa, y_santa)
  else
    # robot's turn
    if ch == '^'
      y_robot += 1
    elseif ch == 'v'
      y_robot -= 1
    elseif ch == '>'
      x_robot += 1
    elseif ch == '<'
      x_robot -= 1
    end

    co = (x_robot, y_robot)
  end

  visited[co] = get(visited, co, 0) + 1
  i += 1
end

println(length(visited))
