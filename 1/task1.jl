include("sample.jl")
r = Robot("untitled.sit",animate = true)
for side in [Nord, West, Sud, Ost]
    steps = []
    c = moveline!(r, side, true, true)
    shortsteps!(r,c,false,false)
end