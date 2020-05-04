# This file was generated, do not modify it. # hide
b = board("b2", xlim=[-1, 15], ylim=[-0.5, 2.5])
@jsf f1(t) = t - sin(t)
@jsf f2(t) = 1 - cos(t)
s = slider("t", [[0,2.1],[6,2.1],[0,π,5π]])
@jsf fb() = val(t)
@jsf pa() = f1(val(t))
@jsf pb() = f2(val(t))
b ++ (f1, f2, s, fb, pa, pb)
b ++ plot(f1, f2; a=0, b=fb, dash=2)
b ++ point(pa, pb, withlabel=false)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide