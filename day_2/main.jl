cd("day_2")

function part_1()
    total = 0
    open("input.txt") do f
        for line in eachline(f)
            nums = parse.(Int32, split(line))
            total += maximum(nums) - minimum(nums)
        end
    end
    println(total)
end

function find_num(nums)
    nums = sort(nums)
    for (k, i) in enumerate(nums[2:end])
        for j in nums[1:k]
            if i % j == 0
                return i / j
            end
        end
    end
end

function part_2()
    total = 0
    open("input.txt") do f
        for line in eachline(f)
            nums = parse.(Int32, split(line))
            total += find_num(nums)
        end
    end
    println(total)
end

part_1()
part_2()
