include("../sample.jl")
r = Robot("untitled.sit",animate = true)

#какой то стремный частный случай не помню зачем но удалять нежелательно
function punkteer!(r,start::Int,side::HorizonSide)
    t = 2
    back = []
    if start == 1
        putmarker!(r)
        c = movestep!(r,side,false,true)
        push!(back,c)
    end

    while !isborder(r,side)
        k = mod(t,2)
        if k==0
            c = movestep!(r,side,true,true)
            push!(back,c)
        else
            c = movestep!(r,side,false,true)
            push!(back,c)
        end
        t+=1
    end
    if isborder(r,Nord) && isborder(r,Ost)
        trig = 1
    else
        trig = 0
    end
    back = listinverse!(back)
    shortsteps!(r,back,false,false)
    return trig
end

function f()
    back = []
    c = longsteps!(r,[West,Sud],false,true)
    back = listtolist!(back,c)
    c = length(c)
    trig = 0
    if mod(c,2)==1
        k = 2
    else
        k = 3
    end
    sd = Nord
    sd1 = Ost
    while trig == 0
        mode = mod(k,2)
        trig = punkteer!(r,mode,sd1)
        k+=1
        movestep!(r,sd,false,false)
    end
    longsteps!(r,[Sud,West],false,false)
    #=back = listinverse!(back)
    back = listreverse!(back)
    shortsteps!(r,back,false,false)=#
end
f()