cd(@__DIR__)

function part_1()
    open("input.txt") do f
        global lengths = read(f, String) |> x->strip(x, ['\n']) |> x->split(x, ",") |> x->parse.(Int, x)
    end
    cur_pos = 1
    skip_size = 0
    arr = collect(0:255)
    # arr = collect(0:4)
    a_len = length(arr)
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

    println(arr[1] * arr[2])
end

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

function part_2()
    open("input.txt") do f
        # conversion to ascii
        global nums = read(f, String) |> x->strip(x, ['\n'])
    end

    tot_hash = knot_hash(nums)
    println(tot_hash)
end

@time part_1()
@time part_2()
