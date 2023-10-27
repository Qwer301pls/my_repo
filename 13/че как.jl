function f()
    for x in [true,false]
        for y in [true,false]
            c = x&y
            #c = !((!(x||x))||(!(y||y)))
            println(x," ",y," ",c)
        end
    end
end
f()