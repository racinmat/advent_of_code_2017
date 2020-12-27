cd(@__DIR__)

using LightGraphs, MetaGraphs, TikzGraphs

function parse_row(row)
    m = match(r"^(\w+) \((\d+)\)( -> (.*))?$", row)
    m[1], m[2], m[4]
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
    g = MetaDiGraph(length(nodes))
    for (i, (node, value, edges)) in enumerate(nodes)
        set_prop!(g, i, :name, node)
        if ! isnothing(edges)
            for edge in split(edges, ", ")
                add_edge!(g, n[node], n[edge])
            end
        end
    end
    root = filter(x-> indegree(g, x) == 0, vertices(g))[1]
    println(get_prop(g, root, :name))
end

function str_node(g, v)
    if outdegree(g, v) == 0
        return string(get_prop(g, v, :sum_value))
    end
    return string(get_prop(g, v, :sum_value)) * " = " * string(get_prop(g, v, :value)) * " + [" * join([str_node(g, w) for w in outneighbors(g, v)], ", ") * "]"
end

function print_with_children(g, v)
    println("$(get_prop(g, v, :sum_value)) = $(get_prop(g, v, :value)) + [$([get_prop(g, w, :value) for w in outneighbors(g, v)])]")
end

calc_sum_values!(g, v::Array) = map(i->calc_sum_values!(g, i), v)

function calc_sum_values!(g, v::Integer)
    sum_value::Int = get_prop(g, v, :value)
    if outdegree(g, v) > 0     # is leaf
        sum_value += calc_sum_values!(g, outneighbors(g, v)) |> sum
    end
    set_prop!(g, v, :sum_value, sum_value)
    sum_value
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
    g = MetaDiGraph(length(nodes))
    for (i, (node, value, edges)) in enumerate(nodes)
        set_prop!(g, i, :name, node)
        set_prop!(g, i, :value, parse(Int, value))
        if ! isnothing(edges)
            for edge in split(edges, ", ")
                add_edge!(g, n[node], n[edge])
            end
        end
    end

    # calculating depth
    root = filter(x-> length(inneighbors(g, x)) == 0, vertices(g))[1]
    # setting sum_value recursively
    calc_sum_values!(g, root)

    for v in vertices(g)
        # everyone checking its children
        sum_vals = [get_prop(g, x, :sum_value) for x in outneighbors(g, v)]
        if (length(sum_vals) < 2) | all(x -> x == first(sum_vals), sum_vals)
            continue
        end
        if (sum_vals |> unique |> length) != 2
            continue
        end
        node_val = [get_prop(g, x, :value) for x in outneighbors(g, v)]
        vals_hist = Dict([(i,count(x->x==i, sum_vals)) for i in unique(sum_vals)])
        _, bad_val = findmin(vals_hist)
        _, good_val = findmax(vals_hist)
        diff_idx = findall(x->x==bad_val, sum_vals)[1]
        elem_diff = good_val - bad_val
        println("sum vals: $sum_vals")
        println("children: $(outneighbors(g, v))")
        println("correct value: $(elem_diff + node_val[diff_idx])")
        println(v)
        println(get_prop(g, v, :name))
        println(get_prop(g, v, :value))
        println(get_prop(g, v, :sum_value))
        # todo: I should evaluate from max depth to lower, and find the first one to be more robust
    end

    # checking sums
    #println(get_prop(g, root, :name))
end

part_1()
part_2()

# sum vals: [8957, 8957, 8964]
# children: [538, 614, 1326]
# correct value: 65
# 815
# lsire
# 61685
# 88563
# sum vals: [88556, 88556, 88556, 88563, 88556]
# children: [93, 347, 642, 815, 897]
# correct value: 61678
# 1237
# wiapj
# 55
# 442842
# sum vals: [1777, 1777, 1777, 1777, 1784]
# children: [394, 612, 679, 768, 1046]
# correct value: 1072
# 1326
# ycpcv
# 72
# 8964
