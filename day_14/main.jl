cd(@__DIR__)

using LightGraphs

function knot_hash(val::String)
    global lengths = vcat(val |> collect |> x->Int.(x), [17, 31, 73, 47, 23])

    cur_pos = 1
    skip_size = 0
    arr = collect(0:255)
    # arr = collect(0:4)
    a_len = length(arr)
    for i in 1:64
        for num in lengths
            if (cur_pos+num-1) > a_len
                split_idx = cur_pos+num-1-a_len
                subarr = reverse(vcat(arr[cur_pos:end], arr[1:split_idx]))
                arr[cur_pos:end] = subarr[1:end-split_idx]
                arr[1:split_idx] = subarr[end-split_idx+1:end]
            else
                arr[cur_pos:cur_pos+num-1] = reverse(arr[cur_pos:cur_pos+num-1])
            end
            pos_mod = (cur_pos+skip_size+num) % a_len
            cur_pos = pos_mod == 0 ? a_len : pos_mod
            skip_size += 1
        end
    end

    tot_hash = ""
    for i in 0:15
        block_hash = 0
        for j in arr[i*16+1:(i+1)*16]
            block_hash ⊻= j
        end
        tot_hash *= lpad(string(block_hash, base=16),2,"0")
    end
    tot_hash
end

function part_1()
    layers = Dict{Int, Int}()
    open("input0.txt") do f
        global seed = read(f, String) |> x->strip(x, ['\n'])
    end
    usages = 0
    for i in 0:127
        row_hash = knot_hash(seed * "-$i")
        row_usages = join.(zip(row_hash[1:2:end], row_hash[2:2:end])) |> x->parse.(
                   Int, x, base=16) |> x->string.(x, base=2) |> x->lpad.(x,
                   8, "0") |> join |> x->split(x, "") |> x->parse.(Int, x) |> sum
        usages += row_usages
    end
    println(usages)
end

function idx_flatten(cindex::CartesianIndex, n::Int)
    (cindex[1]-1)*n+cindex[2]
end

function idx_flatten(index::Tuple{Int, Int}, n::Int)
    (x, y) = index
    (x-1)*n+y
end

function idx_deflatten(i::Int, n::Int)
    if i%n == 0
        return CartesianIndex((i÷n), n)
    else
        return CartesianIndex((i÷n) + 1, i%n)
    end
end

function idx2to1(n)
    i -> idx_flatten(i, n)
end

function idx1to2(n)
    i -> idx_deflatten(i, n)
end

function part_2()
    layers = Dict{Int, Int}()
    open("input.txt") do f
        global seed = read(f, String) |> x->strip(x, ['\n'])
    end
    grid_m = zeros(Int, 128, 128)
    for i in 0:127
        row_hash = knot_hash(seed * "-$i")
        row_usages = join.(zip(row_hash[1:2:end], row_hash[2:2:end])) |> x->parse.(
                   Int, x, base=16) |> x->string.(x, base=2) |> x->lpad.(x,
                   8, "0") |> join |> x->split(x, "") |> x->parse.(Int, x)
        grid_m[i+1, :] = row_usages
    end

    g = LightGraphs.SimpleGraphs.grid([128, 128])
    idx = idx2to1(128)
    idx2 = idx1to2(128)
    for i in idx.(findall(x->x==0, grid_m))
        # rem_vertex!(g, i)
        for n in copy(neighbors(g, i))
        # for n in neighbors(g, i)
            removed = rem_edge!(g, n, i)
            @assert removed
        end
        # @assert degree(g, idx(i)) == 0
    end
    println(connected_components(g) |> x->filter(i->minimum(grid_m[idx2.(i)]) == 1, x) |> length)
end
# minimum(grid_m[idx2.(cc)]) == 1
part_1()
@time part_2()
