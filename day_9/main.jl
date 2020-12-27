cd(@__DIR__)

function part_1()
    open("input.txt") do f
        global line = read(f, String) |> x->strip(x, ['\n'])
    end
    cur_depth = 0
    garbage = false
    total_score = 0
    group_score = 0
    skip_next = false
    for char in line
        if skip_next
            skip_next = false
        elseif char == '!'
            skip_next = true
        elseif garbage && char != '>'
            continue
        elseif char == '>'
            garbage = false
        elseif char == '<'
            garbage = true
        elseif char == '{'
            cur_depth += 1
        elseif char == '}'
            group_score += cur_depth
            cur_depth -= 1
            total_score += group_score
            group_score = 0
        end
    end
    println(total_score)
end

function part_2()
    open("input.txt") do f
        global line = read(f, String) |> x->strip(x, ['\n'])
    end
    total_garbage = 0
    garbage = false
    skip_next = false
    for char in line
        if skip_next
            skip_next = false
        elseif char == '!'
            skip_next = true
        elseif garbage && char != '>'
            total_garbage += 1
        elseif char == '>'
            garbage = false
        elseif char == '<'
            garbage = true
        end
    end
    println(total_garbage)
end

part_1()
part_2()
