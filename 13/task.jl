include("../sample2.jl")
r = Robot("untitled.sit",animate = true)

function punkteer!(r, start::Int, side::HorizonSide)
    if start == 1
        creepwalk!(r,side,false)
    end
    while !isborder(r,side)
        putmarker!(r)
        creepwalk!(r,side,false)
    end
end

function snake!(Robot, (move_side, next_row_side)::NTuple{2,HorizonSide})
    y = countdonesteps!(r,Sud)
    x = countdonesteps!(r,West)
    start = mod((x+y),2)
end

function f()
    #snake!(r, (Ost,Nord))
    moveline!(r,Ost,()->false)
end
f()