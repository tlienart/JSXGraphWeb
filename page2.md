@def hasjsx = true
@def reeval = true
@def mintoclevel = 2

# JSXGraph Examples (2)

\toc

```julia:ex0
#hideall
using JSXGraph
println("~~~<script>$(JSXGraph.PREAMBLE)</script>~~~")
```
\textoutput{ex0}

[Back to first page](/)


### Draggable exponential function

Original example: [link](https://jsxgraph.org/wiki/index.php/Draggable_exponential_function).

$$ f(x) = \exp(\alpha x) $$

For a modifiable point $\alpha$.

@@example
```julia:ex1
b = board(xlim=[-5,5], ylim=[-2,20], axis=true)
b ++ point("α", 1, ℯ, label=js"{fontsize:20}")
@jsf f(x) = exp(x * log(valy(α))/valx(α))
b ++ plot(f)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```
\textoutput{ex1}
@@

**Notes**:
* you can pass a dictionary of styles via a `js` string using `js"..."`
* `valy` and `valx` return the $x$ and $y$ coordinate of a point.

### Lituus

Original example: [link](https://jsxgraph.org/wiki/index.php/Lituus).

$$ r^2\theta = k $$

where $k$ is controlled by a slider.

@@example
```julia:ex2
b = board(xlim=[-10,10], ylim=[-10,10], axis=true)
b ++ slider("k", [[1,8],[7,8],[0,4,10]])
@jsf f(φ) = 2*sqrt(val(k)/φ)
b ++ plot(f, a=0, b=8π, curvetype="polar")
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```
\textoutput{ex2}
@@
