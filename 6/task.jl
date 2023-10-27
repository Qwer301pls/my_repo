include("../sample.jl")
r = Robot("untitled.sit",animate = true)

function f()
    for side in [Ost,Sud,West,Nord]
        back = []
        t = 0
        k = 1
        while k!=0
            c = moveline!(r,side,false,true)
            back = listtolist!(back,c)
            k = iswall!(r,side)
            if  k!=0
                c = creepwalk!(r,side,true)
                back = listtolist!(back,c)
            end
        end
        putmarker!(r)
        back = listinverse!(back)
        back = listreverse!(back)
        shortsteps!(r,back,false,false)
    end
end

f()