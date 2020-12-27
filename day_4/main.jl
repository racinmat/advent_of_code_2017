cd(@__DIR__)

function part_1()
    total = 0
    open("input.txt") do f
        for line in eachline(f)
            words = strip(line, ['\n']) |> split
            total += length(unique(words)) == length(words)
        end
    end
    println(total)
end

function part_2()
    total = 0
    open("input.txt") do f
        for line in eachline(f)
            words = strip(line, ['\n']) |> split
            words = map(x -> x |> collect |> sort |> (y -> string(y...)), words)
            total += length(unique(words)) == length(words)
        end
    end
    println(total)
end

part_1()
part_2()
