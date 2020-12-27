cd(@__DIR__)

function parse_row(row)
    m = match(r"(\d+): (\d+)$", row)
    parse(Int, m[1]), parse(Int, m[2])
end

function part_1()
    layers = Dict{Int, Int}()
    open("input.txt") do f
        for (i, line) in enumerate(eachline(f))
            layer, l_size = strip(line, ['\n']) |> parse_row
            layers[layer] = l_size
        end
    end
    positions = Dict{Int, Int}(layer=>0 for layer in keys(layers))
    tot_cost = 0
    for l in keys(positions)
        first_pos_period = (2*layers[l] - 2)
        caught = l % first_pos_period == 0
        if caught
            tot_cost += l * layers[l]
        end
    end
    println(tot_cost)
end

function part_2()
    layers = Dict{Int, Int}()
    open("input.txt") do f
        for (i, line) in enumerate(eachline(f))
            layer, l_size = strip(line, ['\n']) |> parse_row
            layers[layer] = l_size
        end
    end
    positions = Dict{Int, Int}(l=>0 for l in keys(layers))
    first_poses = Dict{Int, Int}(l=>(2*layers[l] - 2) for l in keys(layers))
    solved = false
    delay = -1
    while !solved
        delay += 1
        solved = true
        for l in keys(positions)
            caught = (l+delay) % first_poses[l] == 0
            if caught
                solved = false
                cur_time = l + delay
                break
            end
        end
    end
    println(delay)
end

part_1()
@time part_2()
# 49 is not right
# 50 is not right
