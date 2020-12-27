cd(@__DIR__)

function part_1()
    num_steps = 0
    seen = Set()
    open("input.txt") do f
        global nums = strip(read(f, String), ['\n']) |> split |> (x -> parse.(Int, x))
    end
    while nums ∉ seen
        push!(seen, copy(nums))
        num_max, idx_max = findmax(nums)
        distr = num_max ÷ (length(nums) - 1)
        if distr == 0
            i = idx_max
            distr = num_max
            while distr > 0
                i = (i % length(nums)) + 1
                nums[i] += 1
                distr -= 1
            end
            nums[idx_max] = 0
        else
            resid = num_max % (length(nums) - 1)
            nums .+= distr
            nums[idx_max] = resid
        end
        num_steps += 1
    end
    println(num_steps)
end

function part_2()
    num_steps = 0
    seen = Dict()
    open("input.txt") do f
        global nums = strip(read(f, String), ['\n']) |> split |> (x -> parse.(Int, x))
    end
    while !haskey(seen, nums)
        seen[copy(nums)] = num_steps
        num_max, idx_max = findmax(nums)
        distr = num_max ÷ (length(nums) - 1)
        if distr == 0
            i = idx_max
            distr = num_max
            while distr > 0
                i = (i % length(nums)) + 1
                nums[i] += 1
                distr -= 1
            end
            nums[idx_max] = 0
        else
            resid = num_max % (length(nums) - 1)
            nums .+= distr
            nums[idx_max] = resid
        end
        num_steps += 1
    end
    println(num_steps - seen[nums])
end

part_1()
part_2()
