# This file was generated, do not modify it. # hide
b = board("dp2", xlim=[0, 1], ylim=[0, 1])
x = range(0, 1, length=100)
y = @. 0.1 * exp(3x) / (3x+0.1)
b ++ plot(x, y, strokecolor=:cornflowerblue, strokewidth=3)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide