cd(@__DIR__)

function part_1()
    num_steps = 0
    open("input.txt") do f
        global nums = strip(read(f, String), ['\n']) |> split |> (x -> parse.(Int, x))
    end
    i = 1
    while i > 0 && i <= length((nums))
        i_tmp = nums[i]
        nums[i] += 1
        i += i_tmp
        num_steps += 1
    end
    println(num_steps)
end

function part_2()
    num_steps = 0
    open("input.txt") do f
        global nums = strip(read(f, String), ['\n']) |> split |> (x -> parse.(Int, x))
    end
    i = 1
    while i > 0 && i <= length((nums))
        i_tmp = nums[i]
        if i_tmp > 2
            nums[i] -= 1
        else
            nums[i] += 1
        end
        i += i_tmp
        num_steps += 1
    end
    println(num_steps)
end

part_1()
part_2()
