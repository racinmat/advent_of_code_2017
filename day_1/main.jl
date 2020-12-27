cd("day_1")

function part_1()
    open("input.txt") do f
        nums = read(f, String)
    end

    nums = strip(nums, ['\r', '\n'])
    nums = parse.(Int32, collect(nums))

    total = 0
    len = length(nums)
    for i in 0:len-1
        prev_a = nums[(i % len) + 1]
        next_a = nums[((i+1) % len) + 1]
        if prev_a == next_a
            total += prev_a
        end
    end

    println(total)
end

function part_2()
    open("input.txt") do f
        nums = read(f, String)
    end

    nums = strip(nums, ['\r', '\n'])
    nums = parse.(Int32, collect(nums))

    total = 0
    len = length(nums)
    for i in 1:length(nums)-1
        prev_a = nums[(i % len) + 1]
        next_a = nums[((i+Int(len / 2)) % len) + 1]
        if prev_a == next_a
            total += prev_a
        end
    end

    # if nums[end] == nums[1]
    #     global total += nums[end]
    # end

    println(total)
end

part_1()
part_2()
