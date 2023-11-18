include("../sample2.jl")
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
    for side in [Nord,Ost,Sud,West]
        sd = [side,HorizonSide(mod(Int(side)+1,2))]
        step = 0
        t = 2
        b = 1
        while b > 0
            csd = sd[mod(t,2)+1]
            if isborder(r,csd)
                b = iswall!(r,csd)
                if b>0
                    c = creepwalk!(r,csd,()->(mod(t,2)==1))
                end
            else
                c = movestep!(r,csd,()->(mod(t,2)==1))
            end
            t += 1
            step+=1
        end
        for i in range(1,1,step-1)
            csd = HorizonSide(mod(Int(sd[mod(t,2)+1])+2,4))
            c = creepwalk!(r,csd)
            t += 1
        end
    end
end
f()