include("../sample2.jl")
r = Robot("untitled.sit",animate = true)

function shuttle!(stop_condition::Function, r::Robot, side::HorizonSide)
    t = 2
    k = 0
    sd1 = side
    sd2 = HorizonSide(mod(Int(side)+2,4))
    while stop_condition()
        if mod(t,2)==0
            countdonesteps!(r,k,sd1)
        else
            countdonesteps!(r,k,sd2)
        end
        t+=1
        k+=1
    end
end
shuttle!(()->(isborder(r,Nord)),r,West)
