include("../sample.jl")
r = Robot("untitled.sit",animate = true)

function mark_cond()
    a::Bool = false
    return a
end

function snake!(stop_cond::Function)
    side = 0
    steps = 1
    while !stop_cond()
        if stop_cond()
            println("LEIIFIJ")
        end
        moveline!(r,HorizonSide(mod(side,4)),()->mark_cond(),()->ismarker(r),steps)
        side += 1
        steps += 1
    end
end
snake!(()->ismarker(r))