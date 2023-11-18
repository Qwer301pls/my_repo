include("../sample2.jl")
r = Robot("untitled.sit",animate = true)
function around!(r::Robot,side::HorizonSide)
    chosen = side
    possible = previous(chosen)
    firstside = possible
    coord = [0,0]
    left = 0
    right = 0
    while !(ismarker(r) && coord[1]==0 && coord[2]==0 && possible==firstside)
        if !isborder(r,chosen)
            chosen = next(chosen)
            possible = next(possible)
            right+=1
        end
        while isborder(r,possible)
            chosen = previous(chosen)
            possible = previous(possible)
            left+=1
        end
        putmarker!(r)
        if possible==Nord
            coord[2]+=1
        end
        if possible==Sud
            coord[2]-=1
        end
        if possible==Ost
            coord[1]+=1
        end
        if possible==West
            coord[1]-=1
        end 
        movestep!(r,possible)
    end
    
    if left>right
        println("внутри")
    else
        println("снаружи")
    end
end
around!(r,Nord)