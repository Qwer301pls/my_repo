include("sample2.jl")
r = Robot("untitled.sit",animate = true)
function around!(r::Robot,side::HorizonSide)
    positions = []
    coord = [0,0]
    chosen = side
    possible = previous(chosen)
    left = 0
    rigth = 0
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
        rotation = rotate(r,chosen,possible)
        chosen = rotation[1]
        possible = rotation[2]
        left = rotation[3]
        rigth = rotation[4]
    end 
    if rigth<left
        println("снаружи")
    else
        println("внутри")
    end
end
around!(r,Nord)