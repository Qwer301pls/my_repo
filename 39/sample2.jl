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

function shortsteps!(robot, steps::Array, mark_cond::Function = ()->false, stop_cond::Function = ()->isborder(r,side))
    p = []
    for s in steps
        movestep!(r, s, ()->mark_cond())
    end
    return steps
end

function anywall(r)
    t = 0
    for i in [Nord,Ost,Sud,West]
        if isborder(r,i)
            t+=1
        end
    end
    if t==0
        return false
    else
        return true
    end
end

# надо докинуть стопконд, пока не знаю как правильнее
function longsteps!(robot, sides::Array, mark_cond::Function = ()->false)
    c = []
    for side in sides
        p = moveline!(robot, side, ()->mark_cond())
        c = listtolist!(c,p)
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
            movestep!(r,sd1)
            if !isborder(r,side)
                window += 1
            end
            steps+=1
        else
            if isborder(r,sd2)
                t = 3
            else
                movestep!(r,sd2)
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
        movestep!(r,sd1)
    end
    return window
end

function creepwalk!(r,side::HorizonSide, mark_cond::Function = ()->false)
    back = []
    sd1 = HorizonSide(mod(Int(side)+1,4))
    sd2 = HorizonSide(mod(Int(side)+3,4))
    steps = 0
    t = 1
    p = 0
    if isborder(r, side)
        while isborder(r,side)
            if isborder(r,sd1)
                t = 2
            end
            if t == 1
                c = movestep!(r,sd1)
                steps += 1
            else
                c = movestep!(r,sd2)
                steps += 1
            end
            push!(back,c)
        end
        c = movestep!(r,side)
        push!(back,c)
        if t == 1
            while isborder(r,sd2)
                c = movestep!(r,side)
                push!(back,c)
                p+=1
            end
        else
            while isborder(r,sd1)
                c = movestep!(r,side)
                push!(back,c)
                p+=1
            end
        end
        while steps!=0
            if t==1
                c = movestep!(r,sd2)
            else
                c = movestep!(r,sd1)
            end
            push!(back,c)
            steps-=1
        end
        if mark_cond()
            putmarker!(r)
        end
        return back
    else
        c = movestep!(r,side,()->mark_cond())
        push!(back,c)
        return [back,p]   # r - число шагов которые робот прошел по направлению движения вдоль стенки
    end
end

#когда есть сколько точно надо
function countdonesteps!(r,need::Int,side::HorizonSide, mark_cond::Function = ()->false)
    canNeed = 0
    for i in range(1,1,need)
        if isborder(r, side)
            break
        end
        movestep!(r,side,()->mark_cond())
        canNeed+=1
    end
    return canNeed
end

#когда есть сколько точно надо через стены
function countdonestepsfinal!(r,need::Int,side::HorizonSide, mark_cond::Function = ()->false)
    canNeed = 0
    for i in range(1,1,need)
        if isborder(r, side)
            c = iswall!(r,side)
            if c == 0
                break
            else
                creepwalk!(r,side)
                if mark_cond()
                    putmarker!(r)
                end
            end
        else
            movestep!(r,side,()->mark_cond())
        end
        canNeed+=1
    end
    return canNeed
end

#когда через стенки до упора
function countdonestepsfinal(r,side::HorizonSide, mark_cond::Function = ()->false)
    canNeed = 0
    if isborder(r,side)
        c = iswall!(r,side)
    end
    while c!=0
        k = moveline!(r,side,()->mark_cond())
        canNeed += k
        c = iswall!(r,side)
        if c!=0
            creepwalk!(r,side)
            canNeed+=1
        end
    end
    return canNeed
end

function previous(side::HorizonSide, mode::Int = 1)
    return HorizonSide(mod(Int(side)+mode,4))
end

function next(side::HorizonSide, mode::Int = 1)
    return HorizonSide(mod(Int(side)+2+mode,4))
end


#делает прямоугольник x,y если есть рамки, делает максимально возможный до x,y
function square!(r,x::Int,y::Int)
    canX = countdonesteps!(r,x-1,Ost,()->true)
    canY = countdonesteps!(r,y-1,Nord,()->true)
    for i in range(1,1,canY)
        for j in range(1,1,canX)
            movestep!(r,West,()->true)
        end
        movestep!(r,Sud,()->true)
        for j in range(1,1,canX)
            movestep!(r,Ost,()->true)
        end
    end
    for j in range(1,1,canX)
        movestep!(r,West,()->true)
    end
end
