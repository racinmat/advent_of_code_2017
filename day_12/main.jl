cd(@__DIR__)

using LightGraphs, MetaGraphs

function parse_row(row)
    m = match(r"(\d+) <-> ((\d+(, )?)+)$", row)
    m[1], m[2]
end

function part_1()
    nodes = Any[]
    n = Dict()
    open("input.txt") do f
        for (i, line) in enumerate(eachline(f))
            node = strip(line, ['\n']) |> parse_row
            push!(nodes, node)
            n[node[1]] = i
        end
    end
    g = MetaGraph(length(nodes))
    for (i, (node, edges)) in enumerate(nodes)
        set_prop!(g, i, :name, node)
        if ! isnothing(edges)
            for edge in split(edges, ", ")
                add_edge!(g, n[node], n[edge])
            end
        end
    end

    println(filter(x->1 in x, connected_components(g))[n["0"]] |> length)
end

function part_2()
    nodes = Any[]
    n = Dict()
    open("input.txt") do f
        for (i, line) in enumerate(eachline(f))
            node = strip(line, ['\n']) |> parse_row
            push!(nodes, node)
            n[node[1]] = i
        end
    end
    g = MetaGraph(length(nodes))
    for (i, (node, edges)) in enumerate(nodes)
        set_prop!(g, i, :name, node)
        if ! isnothing(edges)
            for edge in split(edges, ", ")
                add_edge!(g, n[node], n[edge])
            end
        end
    end

    println(connected_components(g) |> length)
end

part_1()
part_2()
