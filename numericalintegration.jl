using QuadGK

integral, error = quadgk(x -> cos(200x), 0, 1)

quadgk(x -> cos(200x), 0, 1, rtol=1e-3)

# quadgk supports "improper" integrals over infinite and semi-infinite intervals, simply by passing ±Inf for the endpoints.

quadgk(x -> exp(-x), 0, Inf)

# Gaussian Integral

quadgk(x -> exp(-x^2), -Inf, Inf)

# quadgk_count and quadgk_print

quadgk_count(x -> exp(-x), 0, Inf)

# We can also print the evaluation points

quadgk_print(x -> exp(-x), 0, Inf, rtol=1e-2)

# Integrands with singularities and discontinuities
# 1/sqrt(x) blows up at x=0
quadgk_count(x -> 1/sqrt(x), 0, 1)


# Complex integrand

quadgk(x -> 1/sqrt(complex(x)), -1, 0, 1)

# Vector-valued integrand
# It defaults to the Euclidean (L2) norm
quadgk(x -> [1,x,x^2,x^3], 0, 1)

# Changing the norm
quadgk(x -> [1,x,x^2,x^3], 0, 1, norm=v->maximum(abs, v))

# Arbitrary-precision integrals

setprecision(60, base=10) # use 60-digit arithmetic

quadgk_count(x -> exp(-x^2), big"0.0", big"1.0", rtol=1e-50)

# Gauss–Legendre quadrature rule

a = 1; b = 3; n = 5;

x, w = gauss(n, a, b);

[x w]

# For example for f(x)=cos(x)
sum(w .* cos.(x)) # evaluate ∑ᵢ wᵢ f(xᵢ)

sin(3) - sin(1)   # the exact integral

setprecision(30, base=10);

x, w = gauss(BigFloat, n, a, b); @show x; @show w;

# Gauss-Kronrod

a = 1; b = 3; n = 5;

x, w, gw = kronrod(n, a, b); [ x w ] # points and weights
# gw, gives the weights of the embedded 5-point Gaussian-quadrature rule, which corresponds to the even-indexed points x[2:2:end] of the 11-point Gauss–Kronrod rule
[ x[2:2:end] gw ] # embedded Gauss points and weights

fx = cos.(x); # evaluate f(xᵢ)

integral = sum(w .* fx) # ∑ᵢ wᵢ f(xᵢ)

error = abs(integral - sum(gw .* fx[2:2:end])) # |integral - ∑ⱼ wⱼ′ f(xⱼ′)|

abs(integral - (sin(3) - sin(1))) # true error ≈ machine precision

# Gaussian quadrature and arbitrary weight functions

using FastGaussQuadrature
# Note that we are integrating on (-1, 1)
integral, error = quadgk(x -> cos(x), -1, 1)

x, w = gausslegendre(100)
fx = cos.(x)
sum(w .* fx)

x, w = gausslobatto(100)
fx = cos.(x)
sum(w .* fx)

x, w = gaussradau(100)
fx = cos.(x)
sum(w .* fx)

# Note that we are integrating on (0, Inf)
integral, error = quadgk(x -> exp(-x)*x^2, 0, Inf)
x, w = gausslaguerre(100)
fx = x.^2
sum(w .* fx)

# W(x)=(1/sqrt(1-x^2))
integral, error = quadgk(x -> (1/sqrt(1-x^2))*x^2, -1, 1)
x, w = gausschebyshev(100)
fx = x.^2
sum(w .* fx)

# Note that we are integrating on (-Inf, Inf)
integral, error = quadgk(x -> exp(-x^2)*x^2, -Inf, Inf)
x, w = gausshermite(100)
fx = x.^2
sum(w .* fx)

# Write one for Gauss Jacobi as an exercise after studying it 
