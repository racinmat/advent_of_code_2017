cd(@__DIR__)

function parse_row(row)
    m = match(r"^(?P<var_mod>\w+) (?P<op_mod>dec|inc) (?P<num_mod>-?\d+) if (?P<var_comp>\w+) (?P<op_comp><|>|(<=)|(==)|(>=)|(!=)) (?P<num_comp>-?\d+)$", row)
    m["var_mod"], m["op_mod"], parse(Int, m["num_mod"]), m["var_comp"], m["op_comp"], parse(Int, m["num_comp"])
end

function part_1()
    reg = Dict{String,Int}()
    open("input.txt") do f
        for line in eachline(f)
            reg_row = strip(line, ['\n']) |> parse_row
            var_mod, op_mod, num_mod, var_comp, op_comp, num_comp = reg_row
            val_mod = get(reg, var_mod, 0)
            val_comp = get(reg, var_comp, 0)
            # todo: implement different ops
            if eval(Meta.parse("$val_comp $op_comp $num_comp"))
                val_mod = op_mod == "inc" ? val_mod + num_mod : val_mod - num_mod
                reg[var_mod] = val_mod
            end
        end
    end
    println(maximum(values(reg)))
end

function part_2()
    reg = Dict{String,Int}()
    total_max = 0
    open("input.txt") do f
        for line in eachline(f)
            reg_row = strip(line, ['\n']) |> parse_row
            var_mod, op_mod, num_mod, var_comp, op_comp, num_comp = reg_row
            val_mod = get(reg, var_mod, 0)
            val_comp = get(reg, var_comp, 0)
            # todo: implement different ops
            if eval(Meta.parse("$val_comp $op_comp $num_comp"))
                val_mod = op_mod == "inc" ? val_mod + num_mod : val_mod - num_mod
                reg[var_mod] = val_mod
            end
            total_max = max(total_max, maximum(values(reg)))
        end
    end
    println(total_max)
end

part_1()
part_2()
