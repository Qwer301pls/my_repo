include("../sample.jl")
r = Robot("untitled.sit",animate = true)

function f()
    k = 1
    side = Ost
    while isborder(r,Nord)
        for i in range(1,1,k)
            if mod((k+1),2)==1
                movestep!(r,Ost,false,false)
            else
                movestep!(r,West,false,false)
            end
        end
        k+=1
    end
end
f()