# This file was generated, do not modify it. # hide
b = board("brd", xlim=[-2,2], ylim=[-2,2])
b ++ point(0, 0, name="hello")
b.style = "width:250px;height:200px;"
print("""~~~$(JSXGraph.standalone(b))~~~""") # hide