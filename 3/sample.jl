using HorizonSideRobots
HSR = HorizonSideRobots


function movestep!(robot, side, mark::Bool, way::Bool)
    c = []
    if !isborder(robot, side)
        move!(robot, side)
        if mark
            putmarker!(robot)
        end
        if way
            push!(c,HorizonSide(mod(Int(side)+2,4)))
        end
    end
    if way
        return c
    end
end

function moveline!(robot, side, mark::Bool, way::Bool)
    c = []
    while !isborder(robot, side)
        movestep!(robot, side, mark, false)
        if way
            push!(c,HorizonSide(mod(Int(side)+2,4)))
        end
    end
    if way
        return c
    end
end

function shortsteps!(robot, steps::Array, mark::Bool, way::Bool)         #nordn, westn, sudn, ostn
    for s in steps
        movestep!(r, s, mark, way)
    end
end

function longsteps!(robot, sides::Array, mark::Bool, way::Bool)
    c = []
    for s in sides
        p = moveline!(robot, s, mark, way)
        for i in p
            push!(c,i)
        end
    end
    return c
end

function listtolist!(s::Array, n::Array)
    for i in n
        push!(s,i)
    end
    return s
end

function listreverse!(n::Array)
    p = []
    k = length(n)
    for i in range(1,1,k)
        push!(p,last(n))
        pop!(n)
    end
    return p
end

function listinverse!(n::Array)
    p = []
    k = length(n)
    for i in range(1,1,k)
        side = HorizonSide(mod(Int(n[Int(i)])+2,4))
        push!(p,side)
    end
    return p
end

function tocorner!(robot)
    longsteps!(r,[Nord,West],false,true)
end