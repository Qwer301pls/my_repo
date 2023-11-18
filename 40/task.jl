include("sample2.jl")
r = Robot("untitled.sit",animate = true)
function around!(r::Robot,side::HorizonSide)
    positions = []
    coord = [0,0]
    sd1 = next(side)
    sd2 = previous(side)
    chosen = side
    possible = previous(chosen)
    s = 0
    i = 2
    t = 0
    rotation = rotate(r,chosen,possible)
    chosen = rotation[1]
    possible = rotation[2]
    firstside = possible
    while !(t==1 && coord[1]==0 && coord[2]==0 && possible==firstside)
        t = 1
        putmarker!(r)
        coordu = coordupdate(possible,coord[1],coord[2])
        coord[1] = coordu[1]
        coord[2] = coordu[2]
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
        rotation = rotate(r,chosen,possible)
        chosen = rotation[1]
        possible = rotation[2]
    end 
    if (isborder(r,sd1)||isborder(r,sd2))
        push!(positions,[0,0])
    end
    positions = sort!(positions)
    while i < length(positions)+1
        s += abs(positions[Int(i)][2]-positions[Int(i)-1][2])-1
        i+=2
    end
    println(s)
end
around!(r,Nord)