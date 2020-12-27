cd("day_3")

function part_1()
    open("input.txt") do f
        global index = parse(Int, strip(read(f, String), ['\n']))
    end
    # estimate the square size, which is the
    square_size = Int(ceil(sqrt(index)))
    last_round_start = (square_size - 1)^2
    rect_idx = index - last_round_start
    side_num = rect_idx ÷ square_size
    side_idx = rect_idx % square_size
    side_dist = abs(side_idx - square_size ÷ 2)
    to_middle = square_size ÷ 2
    println(to_middle + side_dist)
end

function move(x::Int, y::Int, dir::Int)
    if dir == 0
        return x - 1, y
    elseif dir == 1
        return x, y - 1
    elseif dir == 2
        return x + 1, y
    elseif dir == 3
        return x, y + 1
    end
end

function is_border(x::Int, y::Int, s::Int)
    if ((x - 1) == y) && (x <= (s ÷ 2))
        return true
    elseif (x + y) == (s + 1)
        return true
    elseif (x + y) == (s + 1)
        return true
    elseif (x == y) && (x > (s ÷ 2))
        return true
    end
    false
end

function part_2()
    open("input.txt") do f
        global index = parse(Int, strip(read(f, String), ['\n']))
    end
    # todo: udělat part 2
    # upper bound is fibonacci
    # fibonaccis upper bound is
    ub_const = (1 + sqrt(5))/2
    fib_index_lb = ceil(log(ub_const, index))+1
    s = Int(ceil(sqrt(fib_index_lb)))
    s = 10  # assume some large number, fuck bounds
    m = zeros(Int32, s, s)
    x_cur = Int(ceil((s + 1) / 2))
    y_cur = x_cur - 1
    i_cur = 1
    dir = 3
    cur_rect = 1
    prev_i = -1
    while prev_i <= index
        m[x_cur, y_cur] = i_cur
        x_cur, y_cur = move(x_cur, y_cur, dir)
        i_cur = sum(m[max(x_cur-1, 0):min(x_cur+1, s), max(y_cur-1, 1):min(y_cur+1, s)])
        if is_border(x_cur, y_cur, s)
            dir = (dir + 1) % 4
            if dir == 0
                cur_rect += 1
            end
        end
        display(m)
        prev_i = i_cur
    end
    print(i_cur)
end

part_1()
part_2()
