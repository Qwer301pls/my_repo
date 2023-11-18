include("../sample2.jl")
r = Robot("untitled.sit",animate = true)

function rmoveline!(r::Robot,side::HorizonSide,steps::Int,rev::Bool)
    movestep!(r,side)
    if isborder(r,side)
        side = HorizonSide(mod(Int(side)+2,4))
        rev = true
        steps = steps*2
    end
    if rev==false
        return rmoveline!(r,side,steps+1,rev)
    else
        if steps>-1
            return rmoveline!(r,side,steps-1,rev)
        else
            return "ready"
        end
    end
end

rmoveline!(r,Nord,0,false)