# This file was generated, do not modify it. # hide
b = board(xlim=[-2,2], ylim=[-1,2])
b ++ slider("aa", [[-1,1.5],[1,1.5],[0,1.5,3]])
@jsf foo(x) = val(aa)*x^2 - 1
b ++ plot(foo, dash=2)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide