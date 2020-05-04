@def hasjsx = true
@def reeval = true
@def mintoclevel = 2

# JSXGraph Examples

\toc

## Installation

`JSXGraph` is registered so to install it do

```julia-repl
julia> using Pkg; Pkg.add("JSXGraph")
julia> using JSXGraph
```

```julia:ex0
#hideall
using JSXGraph
println("~~~<script>$(JSXGraph.PREAMBLE)</script>~~~")
```
\textoutput{ex0}

If you use `Juno`, board objects should appear in your plot pane.
If you use a terminal, board objects should appear in an independent [Blink](https://github.com/JuliaGizmos/Blink.jl) window.

IJulia is **not supported** at the moment (it requires some gymnastics with loading libraries which I haven't figured out yet, help is welcome).

## Getting started

Everything happens on a `Board` object which you can declare with the `board` function.
Things can be placed on a board relative to the board limits which can be specified with `xlim` and `ylim`.
To add an object on a board, you can either do `obj |> b` or `b ++ obj` where `obj` is either a single object or a group of objects.

The **style** of the board can be set by specifying the `style` attribute, that specifies how the board will look on the page.

@@example
```julia:ex0b
b = board("brd", xlim=[-2,2], ylim=[-2,2])
b ++ point(0, 0, name="hello")
b.style = "width:250px;height:200px;"
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```
\textoutput{ex0b}
@@

### Functions

To use a function on a board, you need to use `@jsf` in front of the function definition.
That will define an object which encapsulates the function as well as a Javascript representation of the function.
You can add functions to boards the same way you would add objects.
If an object uses a function and that the function hasn't been added to the board, it will be added automatically.

**Note**: if you use a function that _depends_ on another function, that other function also needs to be `@jsf` and needs to be added to the board.

```julia:exf1
@jsf foo(x) = 5x
@show foo(3)
```
\show{exf1}

Whatever is in the body of the function needs to be understandable by Javascript. Basic math functions can be used (`sin, math, cos, exp, ...`).
You could extend this by also using [`math.js`](https://mathjs.org/docs/reference/functions.html).

### Controllers

Controllers are the entry points for interactivity.
For instance, a _slider_ can be used to specify a value which can be used by another object on the board.
In order to access the value specified by a controller, you need to use the `val` function like so:

```julia
slider = slider("s", ...)
@jsf vs() = val(s)
point(0, vs, ...)
```

**Note**: observe that it's the _given name_ of the slider that is used (`s`) not the variable name (`slider`).

`@jsf` and `val` are basically the only two things to keep in mind when working with JSXGraph.
Let's see some examples.

### Options

The original library's documentation [jsxgraph.js](https://jsxgraph.org/docs/index.html) is useful to know what options you can pass to objects.

## Simple curves

### Basic curve

A parabola that depends on a slider:

$$ f(x) = ax^2 $$

where $a$ is given by the value of a slider.

@@example
```julia:ex1
b = board("b1", xlim=[-2,2], ylim=[-1,2])
b ++ slider("a", [[-1,1.5],[1,1.5],[0,1.5,3]])
@jsf foo(x) = val(a)*x^2 - 1
b ++ plot(foo, dash=2)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```
\textoutput{ex1}
@@

**Notes**:
* observe that the slider is specified with three elements:
    * the first element is the position of the initial point `[xa, ya]`
    * the second element is the position of the final point `[xb, yb]`
    * the last element indicate the values `[va, vm, vb]` where `va` is the lower value, `vb` the upper one and `vm` the default one.
* the option `dash=2` is one among the many options you can pass to a [`Functiongraph` object](https://jsxgraph.org/docs/symbols/Functiongraph.html) some noteworthy ones:
    * `strokecolor` where you can pass anything that would work with CSS,
    * `strokewidth` a number indicating the width of the stroke


### Parametric curves

A parametric curve with

$$ \begin{cases}
x(t) &=\quad t - \sin(t)\\
y(t) &=\quad 1 - \cos(t)
\end{cases} \quad \text{for} \quad t \in [0, 5\pi]$$

where `t` is controlled by a slider.

@@example
```julia:ex2
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
```
\textoutput{ex2}
@@

Let's do another one that looks fancier:

$$ \begin{cases}
x(t) &=\quad A\sin(at + \delta) \\
y(t) &=\quad B\sin(bt)
\end{cases} \quad \text{for} \quad t \in [0, 2\pi]$$

where $a, b, A$ and $B$ are controlled by sliders.

@@example
```julia:ex3
b = board("b3", xlim=[-12, 12], ylim=[-10,10])
b ++ (
    slider("a", [[-11,7],[-5,7],[0,3,6]], name="a"),
    slider("b", [[-11,5],[-5,5],[0,2,6]], name="b"),
    slider("A", [[1,7],[7,7],[0,3,6]], name="A"),
    slider("B", [[1,5],[7,5],[0,3,6]], name="B"),
    slider("delta", [[2,-7],[6,-7],[0,0,π]], name="&delta;")
    )
@jsf f1(t) = val(A)*sin(val(a)*t+val(delta))
@jsf f2(t) = val(B)*sin(val(b)*t)
b ++ plot(f1, f2, a=0, b=2π,
          strokecolor="#aa2233", strokewidth=3)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```
\textoutput{ex3}
@@

### Data plots

@@example
```julia:dp1
b = board("dp1", xlim=[0, 1], ylim=[0, 1])
x = rand(10)
y = rand(10)
b ++ plot(x, y)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```
\textoutput{dp1}
@@

\\

@@example
```julia:dp2
b = board("dp2", xlim=[0, 1], ylim=[0, 1])
x = range(0, 1, length=100)
y = @. 0.1 * exp(3x) / (3x+0.1)
b ++ plot(x, y, strokecolor=:cornflowerblue,
          strokewidth=3)
b.style = "width:250px;height:200px;" # hide
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```
\textoutput{dp2}
@@
