include("sample.jl")
r = Robot("untitled.sit",animate = true)
function f()
    k=3
    back = []
    c = longsteps!(r,[Nord, West],false,true)
    putmarker!(r)
    back=listtolist!(back,c)
    trig = 0
    while trig<2
        n = mod(k,2)
        if n == 0
            c = moveline!(r,West,true,true)
        else
            c = moveline!(r,Ost,true,true)
        end
        back = listtolist!(back,c)
        shortsteps!(r,[Sud],true,false)
        back = listtolist!(back,[Nord])
        if (isborder(r,Sud) && isborder(r,Ost)) || (isborder(r,Sud) && isborder(r,West))
            trig+=1
        end
        k+=1
    end   
    back=listreverse!(back)
    shortsteps!(r,back,false,false)
end
f()