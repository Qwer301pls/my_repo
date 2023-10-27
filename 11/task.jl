include("../sample.jl")
r = Robot("untitled.sit",animate = true)

function f()
    back = []
    walls = 0
    trig = 0
    l = ""
    c = longsteps!(r,[West,Sud,West],false,true)
    back = listtolist!(back,c)
    if isborder(r,Nord)
        l*="1"
    else
        l*="0"
    end
    while trig == 0
        l = ""
        if isborder(r,Nord)
            trig = 1
        end
        while !isborder(r,Ost)
            movestep!(r,Ost,false,false)
            if isborder(r,Nord)
                l*="1"
            else
                l*="0"
            end
        end
        while occursin("11",l)
            l = replace(l, "11" => "1")
        end
        while occursin("0",l)
            l = replace(l, "0" => "")
        end
        walls += length(l)
        moveline!(r,West,false,false)
        movestep!(r,Nord,false,false)
    end
    while !isborder(r,Sud)
        move!(r,Sud)
    end

    back = listinverse!(back)
    back = listreverse!(back)
    shortsteps!(r,back,false,false)
    println(walls-1)
end
f()