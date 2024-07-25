Internally, `quadgk` handles infinite limits by the [changes of variables](https://en.wikipedia.org/wiki/Integration_by_substitution)
$$
\int_a^\infty f(x)dx = \int_0^1 f\left(a + \frac{t}{1-t}\right) \frac{1}{(1-t)^2} dt
$$
and
$$
\int_{-\infty}^\infty f(x)dx = \int_{-1}^1 f\left(\frac{t}{1-t^2}\right) \frac{1+t^2}{(1-t^2)^2} dt
$$
respectively.

## Gauss–Kronrod: Error estimation and embedded rules

A good quadrature rule is often not enough: you also want
to have an **estimate of the error** for a given $f(x)$, in order to
decide whether you are happy with your approximate integral or if you
want to get a more accurate estimate by increasing $n$.

The most basic way to do this is to evaluate *two* quadrature rules, one with
fewer points $n' < n$, and use their *difference* as an error
estimate.  (If the error is rapidly converging with $n$, this is usually
a conservative upper bound on the error.)
$$
\text{error estimate} = \Big|
\underbrace{\sum_{i=1}^n w_i f(x_i)}_{\text{first rule}} -
\underbrace{\sum_{j=1}^{n'} w_j' f(x_j')}_{\text{second rule}}
\Big|
$$
Naively, this requires us to evaluate our integrand $f(x)$ an extra
$n'$ times to get the error estimate from the second rule.  However,
we can do better: if the points $\{ x_j' \}$ of the second ($n'$-point) rule
are a *subset* of the points $\{ x_i \}$ of the points from the first
($n$-point) rule, then we only need $n$ function evaluations for the
first rule and can *re-use* them when evaluating the second rule.
This is called an **embedded** (or **nested**) quadrature rule.

There are many ways of designing embedded quadrature rules.  Unfortunately,
the nice Gaussian quadrature rules cannot be directly nested: the $n'$-point
Gaussian quadrature points are *not* a subset of the $n$-point Gaussian
quadrature points for *any* $1 < n' < n$.   Fortunately, there is a slightly
modified scheme that works, called [Gauss–Kronrod quadrature](https://en.wikipedia.org/wiki/Gauss%E2%80%93Kronrod_quadrature_formula): if you start with an $n'$-point Gaussian-quadrature scheme, you can extend it with
$n'+1$ additional points to obtain a quadrature scheme with $n=2n'+1$
points that exactly integrates polynomials up to degree $3n'+1$.
Although this is slightly worse than an $n$-point Gaussian quadrature
scheme, it is still quite accurate, still converges very fast
for smooth functions, and gives you a built-in error estimate that
requires no additional function evaluations.   (In QuadGK, we refer
to the size $n'$ of the embedded Gauss rule as the "order", although
other authors use that term to refer to the degree of polynomials
that are integrated exactly.)

The [`quadgk`](@ref) function uses Gauss–Kronrod quadrature internally,
defaulting to order $n'=7$ (i.e. $n=15$ points), though you can change
this with the `order` parameter.   This gives it both an estimated
integral and an estimated error.  If the error is larger than your requested
tolerance, `quadgk` splits the integration interval into two halves and
applies the same Gauss–Kronrod rule to each half, and continues to
subdivide the intervals until the desired tolerance is achieved, a
process called $h$-[adaptive quadrature](https://en.wikipedia.org/wiki/Adaptive_quadrature).  (An alternative called $p$-adaptive quadrature
would increase the order $n'$ on the same interval.  $h$-adaptive
quadrature is more robust if your function has localized bad behaviors
like sharp peaks or discontinuities, because it will progressively
add more points mostly in these "bad" regions.)