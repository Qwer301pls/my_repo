include("sample.jl")
r = Robot("untitled.sit",animate = true)
function f()
    for side in [Nord,West,Sud,Ost]
        st = 0
        while isborder(r,side)==false && isborder(r,HorizonSide(mod(Int(side)+1,4)))==false
            shortsteps!(r,[side,HorizonSide(mod(Int(side)+1,4))],false,false)
            st += 1
            putmarker!(r)
        end
        side = HorizonSide(mod(Int(side)+2,4))
        for i in range(1,1,st)
            shortsteps!(r,[side,HorizonSide(mod(Int(side)+1,4))],false,false)
        end
    end
end
f()