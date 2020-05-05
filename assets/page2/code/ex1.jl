# This file was generated, do not modify it. # hide
b = board(xlim=[-5,5], ylim=[-2,20], axis=true)
b ++ point("α", 1, ℯ, label=js"{fontsize:20}")
@jsf f(x) = exp(x * log(valy(α))/valx(α))
b ++ plot(f)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide