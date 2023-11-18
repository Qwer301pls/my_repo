include("../sample2.jl")
r = Robot("untitled.sit",animate = true)

function punkteer!(r, start::Int, side::HorizonSide)
    function mark_cond(c::Int)
        if mod(c,2)==0
            return true
        else
            return false
        end
    end
    c = 2
    if start == 1
        putmarker!(r)
        creepwalk!(r,side)
    end
    t = 1
    while t!=0
        while !isborder(r,side)
            movestep!(r,side,()->mark_cond(c))
            c+=1
        end
        t = iswall!(r,side)
        if t>0
            p = creepwalk!(r,side,()->mark_cond(c))[1]
            c+=Int(p)
            c+=1
        end
    end
    #=    если не надо через стены
    while !isborder(r,side)
        movestep!(r,side,()->mark_cond(c))
        c+=1
    end=#
    return mod(c,2)
end

function snake!(Robot, (move_side, next_row_side)::NTuple{2,HorizonSide})
    t = 0
    y = moveline!(r,Sud)
    x = moveline!(r,West)
    start = mod((length(x)+length(y)+1),2)
    while t==0
        if isborder(r,Nord)
            t=1
        end
        c = punkteer!(r,start,move_side)
        start = mod(start+1,2)
        movestep!(r,next_row_side)
        move_side = HorizonSide(mod(Int(move_side)+2,4))
    end
    longsteps!(r,[Sud,West])
    y = listtolist!(y,x)
    y = listinverse!(y)
    shortsteps!(r,y)
end

snake!(r, (Ost,Nord))
function f()
    
end
f()