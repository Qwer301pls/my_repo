include("sample2.jl")
r = Robot("untitled.sit",animate = true)
function around!(r::Robot,side::HorizonSide)
    sd1 = next(side)
    sd2 = previous(side)
    positions = []
    chosen = side
    possible = previous(chosen)
    coord = [0,0]
    left = 0
    right = 0
    s = 0
    i = 2
    t = 0
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
    firstside = possible
    println(firstside,coord)
    while !(t==1 && coord[1]==0 && coord[2]==0 && possible==firstside)
        t = 1
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
        if (isborder(r,sd1)||isborder(r,sd2)) && !ismarker(r)
            c = wallsp(r)
            if side == Nord || side == Sud
                push!(positions,[coord[2],coord[1]])
                if c[1]==3 && (c[2]==Nord || c[2]==Sud)
                    push!(positions,[coord[2],coord[1]])
                end
            else
                push!(positions,[coord[1],coord[2]])
                if c[1]==3 && (c[2]==West || c[2]==Ost)
                    push!(positions,[coord[1],coord[2]])
                end
            end
        elseif isborder(r,sd1)&&isborder(r,sd2)
            if side == Nord || side == Sud
                push!(positions,[coord[2],coord[1]])
            else
                push!(positions,[coord[1],coord[2]])
            end
        end
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
        #println(possible,coord)
    end 
    if (isborder(r,sd1)||isborder(r,sd2))
        push!(positions,[0,0])
    end
    positions = sort!(positions)
    println(positions)
    while i < length(positions)+1
        s += abs(positions[Int(i)][2]-positions[Int(i)-1][2])-1
        println(positions[Int(i)][2]," ",positions[Int(i)-1][2]," ",abs(positions[Int(i)][2]-positions[Int(i)-1][2])-1)
        i+=2
    end
    println(s)
end
around!(r,Nord)