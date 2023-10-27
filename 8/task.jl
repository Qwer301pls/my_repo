include("../sample.jl")
r = Robot("untitled.sit",animate = true)

function f()
    side = 1
    while !ismarker(r)
        for i in range(1,1,side)
            movestep!(r,HorizonSide(mod(side,4)),false,false)
            if ismarker(r)
                break
            end
        end
        side+=1
    end

end
f()