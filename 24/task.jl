include("../sample2.jl")
r = Robot("untitled.sit",animate = true)

function rmoveline!(r::Robot,side::HorizonSide,steps::Int)
    movestep!(r,side)
    if isborder(r,side)
        side = HorizonSide(mod(Int(side)+2,4))
        rmoveline2!(r,side,div(steps-1,2))
    else
        return rmoveline!(r,side,steps+1)
    end
end

function rmoveline2!(r::Robot,side::HorizonSide,steps::Int)
    movestep!(r,side)
    if steps>-1
        return rmoveline2!(r,side,steps-1)
    else
        return "ready"
    end
end

rmoveline!(r,West,0)