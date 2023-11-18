include("../sample2.jl")
r = Robot("untitled.sit",animate = true)

function rcreepwalk!(r::Robot,side::HorizonSide,steps::Int = 0,rev::Bool = false)
    sd = HorizonSide(mod(Int(side)+3,4))
    if rev
        sd = HorizonSide(mod(Int(side)+1,4))  
    end
    movestep!(r,sd)
    if !isborder(r,side) && rev==false
        rev = true
        sd = HorizonSide(mod(Int(sd)+2,4))
        movestep!(r,side)
    end
    if rev==false
        return rcreepwalk!(r,side,steps+1,rev)
    else
        if steps>-1
            return rcreepwalk!(r,side,steps-1,rev)
        else
            return "ready"
        end
    end
end

rcreepwalk!(r,Nord)