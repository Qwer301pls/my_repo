using HorizonSideRobots
HSR = HorizonSideRobots

function movestep!(robot, side, mark_cond::Function = ()->false)
    if !isborder(robot, side)
        move!(robot, side)
        if mark_cond()
            putmarker!(robot)
        end
    end
    return [side]
end

function moveline!(robot, side, mark_cond::Function = ()->false, stop_cond::Function = ()->isborder(r,side))
    c = []
    while !stop_cond()
        movestep!(robot, side,()->mark_cond())
        push!(c,side)
    end
    return c
end

function shortsteps!(robot, steps::Array, mark::Bool, way::Bool)         #nordn, westn, sudn, ostn
    p = []
    for s in steps
        movestep!(r, s, mark, false)
    end
    k = listinverse!(steps)
    if way
        return k
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
    for i in n
        push!(p,HorizonSide(mod(Int(i)+2,4)))
    end
    return p
end

function tocorner!(robot, side::HorizonSide, long::Bool, mark::Bool, way::Bool)
    if long
        c = longsteps!(r,[side,HorizonSide(mod(Int(side)+1,4))],mark,way)
    else
        c = shortsteps!(r,[side,HorizonSide(mod(Int(side)+1,4))],mark,way)
    end
    if way
        return c
    end
end

function iswall!(r,side::HorizonSide)
    t = 1
    window = 0
    steps = 0
    sd1 = HorizonSide(mod(Int(side)+1,4))
    sd2 = HorizonSide(mod(Int(side)+3,4))
    if !isborder(r,side)
        window += 1
    end
    while t<3
        if isborder(r,sd1)
            t = 2
        end
        if t == 1
            movestep!(r,sd1,false,false)
            if !isborder(r,side)
                window += 1
            end
            steps+=1
        else
            if isborder(r,sd2)
                t = 3
            else
                movestep!(r,sd2,false,false)
                steps-=1
                if steps<0
                    if !isborder(r,side)
                        window += 1
                    end
                end
            end
        end
    end
    for i in range(1,1,-steps)
        movestep!(r,sd1,false,false)
    end
    return window
end

function creepwalk!(r,side::HorizonSide,way::Bool)
    back = []
    sd1 = HorizonSide(mod(Int(side)+1,4))
    sd2 = HorizonSide(mod(Int(side)+3,4))
    steps = 0
    t = 1
    if isborder(r, side)
        while isborder(r,side)
            if isborder(r,sd1)
                t = 2
            end
            if t == 1
                c = movestep!(r,sd1,false,true)
                steps += 1
            else
                c = movestep!(r,sd2,false,true)
                steps += 1
            end
            push!(back,c)
        end
        c = movestep!(r,side,false,true)
        push!(back,c)
        if t == 1
            while isborder(r,sd2)
                c = movestep!(r,side,false,true)
                push!(back,c)
            end
        else
            while isborder(r,sd1)
                c = movestep!(r,side,false,true)
                push!(back,c)
            end
        end
        while steps!=0
            if t==1
                c = movestep!(r,sd2,false,true)
            else
                c = movestep!(r,sd1,false,true)
            end
            push!(back,c)
            steps-=1
        end
        if way
            return back
        end
    
    else
        c = movestep!(r,side,false,true)
        push!(back,c)
        return back
    end
end



#когда есть сколько точно надо
function countdonesteps!(r,need::Int,side::HorizonSide)
    canNeed = 0
    for i in range(1,1,need)
        if isborder(r, side)
            break
        end
        movestep!(r,side,true,false)
        canNeed+=1
    end
    return canNeed
end

#когда есть сколько точно надо через стены
function countdonestepsfinal!(r,need::Int,side::HorizonSide)
    canNeed = 0
    for i in range(1,1,need)
        if isborder(r, side)
            c = iswall!(r,side)
            if c == 0
                break
            else
                creepwalk!(r,side,false)
            end
        else
            movestep!(r,side,true,false)
        end
        canNeed+=1
    end
    return canNeed
end

#когда до упора
function countdonesteps!(r,side::HorizonSide)
    canNeed = 0
    while !isborder(r,side)
        movestep!(r,side,true,false)
        canNeed+=1
    end
    return canNeed
end

#когда через стенки до упора
function countdonestepsfinal(r,side::HorizonSide)
    canNeed = 0
    if isborder(r,side)
        c = iswall!(r,side)
    end
    while c!=0
        k = countdonesteps!(r,side)
        canNeed += k
        c = iswall!(r,side)
    end
    return canNeed
end

function always()
    return true
end

#делает прямоугольник x,y если есть рамки, делает максимально возможный до x,y
function square!(r,x::Int,y::Int)
    canX = countdonesteps!(r,x-1,Ost)
    canY = countdonesteps!(r,y-1,Nord)
    for i in range(1,1,canY)
        for j in range(1,1,canX)
            movestep!(r,West,true,false)
        end
        movestep!(r,Sud,true,false)
        for j in range(1,1,canX)
            movestep!(r,Ost,false,false)
        end
    end
    for j in range(1,1,canX)
        movestep!(r,West,false,false)
    end
end