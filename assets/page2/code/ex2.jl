# This file was generated, do not modify it. # hide
b = board(xlim=[-10,10], ylim=[-10,10], axis=true)
b ++ slider("k", [[1,8],[7,8],[0,4,10]])
@jsf f(φ) = 2*sqrt(val(k)/φ)
b ++ plot(f, a=0, b=8π, curvetype="polar")
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide