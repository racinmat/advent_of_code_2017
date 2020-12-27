cd(@__DIR__)

function dist(a, b)
    # from https://www.redblobgames.com/grids/hexagons/#distances-axial
    (abs(a[1] - b[1]) + abs(a[1] + a[2] - b[1] - b[2]) + abs(a[2] - b[2])) / 2
end

dist(a) = (abs(a[1]) + abs(a[1] + a[2]) + abs(a[2])) / 2

function part_1()
    open("input.txt") do f
        global dirs = read(f, String) |> x->strip(x, ['\n']) |> x->split(x, ",")
    end
    # using https://www.redblobgames.com/grids/hexagons/ axial coordinates
    dir_vec = Dict("n" => [0, -1], "ne" => [1, -1], "se" => [1, 0],
        "s" => [0, 1], "sw" => [-1, 1], "nw" => [-1, 0],)
    cur_pos = [0, 0]
    for dir in dirs
        cur_pos += dir_vec[dir]
    end
    println(Int(dist(cur_pos)))
end

function part_2()
    open("input.txt") do f
        global dirs = read(f, String) |> x->strip(x, ['\n']) |> x->split(x, ",")
    end
    dir_vec = Dict("n" => [0, -1], "ne" => [1, -1], "se" => [1, 0],
        "s" => [0, 1], "sw" => [-1, 1], "nw" => [-1, 0],)
    cur_pos = [0, 0]
    max_dist = 0
    for dir in dirs
        cur_pos += dir_vec[dir]
        max_dist = max(max_dist, Int(dist(cur_pos)))
    end
    println(max_dist)
end

@time part_1()
@time part_2()
