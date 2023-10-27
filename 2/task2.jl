include("sample.jl")
r = Robot("untitled.sit",animate = true)
back = []
c = moveline!(r, Nord, false, true)
back = listtolist!(back,c)
k = longsteps!(r,[West,Sud,Ost,Nord,West],true,true)
back = listtolist!(back,k)
back = listreverse!(back)
shortsteps!(r,back,false,false)