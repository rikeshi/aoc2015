function create_grid(w, h)
  zeros(h, w)
end

function toggle(grid, x, y)
  grid[x, y] = 1 - 1 * grid[x, y]
end

function on(grid, x, y)
  grid[x, y] = 1
end

function off(grid, x, y)
  grid[x, y] = 0
end

function toggle_range(grid, x1, y1, x2, y2)
  for y = y1:y2
    for x = x1:x2
      toggle(grid, x, y)
    end
  end
end

function on_range(grid, x1, y1, x2, y2)
  for y = y1:y2
    for x = x1:x2
      on(grid, x, y)
    end
  end
end

function off_range(grid, x1, y1, x2, y2)
  for y = y1:y2
    for x = x1:x2
      off(grid, x, y)
    end
  end
end

function read_and_apply_ranges(grid, fname)
  for line in eachline(fname)
    m = match(r"^(.+)\s(\d+),(\d+) through (\d+),(\d+)$", line)
    action = m.captures[1]
    x1, y1, x2, y2 = map(x->parse(Int, x)+1, m.captures[2:end])
    if action == "toggle"
      op = toggle_range
    elseif action == "turn on"
      op = on_range
    elseif action == "turn off"
      op = off_range
    end
    op(grid, x1, y1, x2, y2)
  end
end

grid = create_grid(1000, 1000)
read_and_apply_ranges(grid, "input")
println(count(x->x==1, grid))

