include("../sample2.jl")
r = Robot("untitled.sit",animate = true)

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
    println(y)
end

function f()
    snake!(r, (Ost,Nord))
end
f()