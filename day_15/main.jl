cd(@__DIR__)

function parse_row(row)
    m = match(r".* with (\d+)$", row)
    parse(Int, m[1])
end

function a_next(val)
    (val * 16807) % 2147483647
end

function b_next(val)
    (val * 48271) % 2147483647
end

function part_1()
    open("input.txt") do f
        global seed_a, seed_b = eachline(f) |> collect |> x->strip.(x, ['\n']) |> x->parse_row.(x)
        # seed_a, seed_b = eachline(f) |> collect |> x->strip.(x, ['\n']) |> x->parse_row.(x)
    end

    val_a = seed_a
    val_b = seed_b
    total = 0
    for i in 1:4*10^7
    # for i in 1:5
        # global val_a = a_next(val_a)
        # global val_b = b_next(val_b)
        val_a = a_next(val_a)
        val_b = b_next(val_b)
        # println("$val_a $val_b")
        # println("$(string(val_a % 2^16, base=2)) $(string(val_b % 2^16, base=2))")
        if (val_a % 65536) == (val_b % 65536)
            # global total += 1
            total += 1
        end
    end
    println(total)
end

function my_gen(init_val, next_fn, modulo)
    val = init_val
    channel = Channel(2)
    @async begin
        while true
            val = next_fn(val)
            if val % modulo == 0
                put!(channel, val)
            end
        end
    end
    channel
end

function part_2()
    open("input.txt") do f
        global seed_a, seed_b = eachline(f) |> collect |> x->strip.(x, ['\n']) |> x->parse_row.(x)
        # seed_a, seed_b = eachline(f) |> collect |> x->strip.(x, ['\n']) |> x->parse_row.(x)
    end

    gen_a = my_gen(seed_a, a_next, 4)
    gen_b = my_gen(seed_b, b_next, 8)
    total = 0

    for i in 1:5*10^6
    # for i in 1:5
        # global val_a = take!(gen_a)
        # global val_b = take!(gen_b)
        val_a = take!(gen_a)
        val_b = take!(gen_b)
        # println("$val_a $val_b")
        # println("$(string(val_a % 2^16, base=2)) $(string(val_b % 2^16, base=2))")
        if (val_a % 65536) == (val_b % 65536)
            # global total += 1
            total += 1
        end
    end
    println(total)
end

@time part_1()
@time part_2()
