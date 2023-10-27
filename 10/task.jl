include("../sample.jl")
r = Robot("untitled.sit",animate = true)

function f()
    horizontal = []
    vertical = []
    start = []
    back = []
    t = 2
    size = 2
    for i in range(1,1,size * 2)
        push!(horizontal,Ost)
    end
    for i in range(1,1,size)
        push!(vertical,Nord)
        push!(start,Ost)
    end
    c = longsteps!(r,[West,Sud],false,true)
    back = listtolist!(back,c)

    while !isborder(r,Nord)
        if mod(t,2)==1
            shortsteps!(r,start,false,false)
        end
        while !isborder(r,Ost)
            square!(r,size,size)
            shortsteps!(r,horizontal,false,false)
        end
        moveline!(r,West,false,false)
        shortsteps!(r,vertical,false,false)
        t+=1
    end
end
f()