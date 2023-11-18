include("../sample2.jl")
r = Robot("untitled.sit",animate = true)

function rmoveline!(r::Robot, side::HorizonSide, mark_cond::Function = ()->false)
    movestep!(r,side)
    if !isborder(r,side)
        return rmoveline!(r,side,()->mark_cond())
    else
        return 0
    end
end
rmoveline!(r,Nord)