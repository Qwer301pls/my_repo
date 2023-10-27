include("../sample.jl")
r = Robot("untitled.sit",animate = true)

function iscorner(r)
    k = 0
    for side in [Ost,West,Nord,Sud]
        if isborder(r,side)
            k+=1
        end
    end
    return k
end


function f()
    for side in [Nord,West,Sud,Ost]
        println(side,HorizonSide(mod(Int(side)+1,4)))
        st = 0

        while t==0
            println(iscorner(r))
            creepwalk!(r,side,false)
            creepwalk!(r,HorizonSide(mod(Int(side)+1,4)),false)
            st += 1
            putmarker!(r)
        end
        side = HorizonSide(mod(Int(side)+2,4))
        println(side,HorizonSide(mod(Int(side)+1,4)))
        for i in range(1,1,st)
            creepwalk!(r,side,false)
            creepwalk!(r,HorizonSide(mod(Int(side)+1,4)),false)
        end
    end
end
f()