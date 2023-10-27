include("../sample.jl")
r = Robot("untitled.sit",animate = true)

function movenrotatecheck!(r,side::HorizonSide,sidesec::HorizonSide, way::Bool)
    p = []
    k = 0
    while !isborder(r,side)
        if isborder(r,sidesec)
            k = 1
            putmarker!(r)
        end
        c = movestep!(r,side,false,way)
        push!(p,c)
    end
    c = movestep!(r,sidesec,false,way)
    push!(p,c)
    return [p,k]
end

function f()
    back = []
    trig = 0
    t = 2
    c = longsteps!(r,[West,Sud,West],false,true)
    back = listtolist!(back,c)
    side = 3
    sidesec = 0

    for j in range(0,1,4)
        trig = 0
        t = 2
        while trig == 0
            if mod(t,2)==0
                c,trig = movenrotatecheck!(r,HorizonSide(mod(side,4)),HorizonSide(mod(sidesec,4)),true)
            else
                c,trig = movenrotatecheck!(r,HorizonSide(mod(side+2,4)),HorizonSide(mod(sidesec,4)),true)
            end
            println(trig)
            back = listtolist!(back,c)
            t+=1
        end
        c = tocorner!(r,HorizonSide(mod(side+2,4)),true,false,true)
        back = listtolist!(back,c)
        side+=1
        sidesec+=1
    end
    c = longsteps!(r,[Sud,Ost,Nord,West,Sud],true,true)
    back = listtolist!(back,c)

    back = listreverse!(back)
    back = listinverse!(back)
    shortsteps!(r,back,false,false)

end
f()