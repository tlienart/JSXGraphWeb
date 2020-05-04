# This file was generated, do not modify it. # hide
b = board("dp1", xlim=[0, 1], ylim=[0, 1])
x = rand(10)
y = rand(10)
b ++ plot(x, y)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide