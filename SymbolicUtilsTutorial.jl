using SymbolicUtils

@syms w z α::Real β::Real

using SymbolicUtils: symtype

symtype(w), symtype(z),  symtype(α), symtype(β)

@show w isa Number

@show α isa Real

@show typeof(w)
@show typeof(α)

expr1 = α*sin(w)^2 + β*cos(z)^2
expr2 = α*cos(z)^2 + β*sin(w)^2

expr1 + expr2

2w + 3w - 3z + α

α + 5w - 3z

(z + w)*(α + β)

(w + z)*(α + β)

5 + 2w - 3z + α - (β + 5//3) + 3w - 2 + 3//2 * β

(4//3) + α + 5w + (1//2)*β - 3z

@syms f(x) g(x::Real, y::Real)::Real

f(z) + g(1, α) + sin(w)

g(1, z)

g(2//5, g(1, β))

g(2//5, g(1, β))

2 * (w+w+α+β + sin(z)^2 + cos(z)^2 - 1)

2(α + β + 2w + cos(z)^2 + sin(z)^2 - 1)

simplify(2 * (w+w+α+β + sin(z)^2 + cos(z)^2 - 1))

2(α + β + 2w)

# Term Rewriting

@syms w z α::Real β::Real

r1 = @rule sin(2(~x)) => 2sin(~x)*cos(~x)

r1(sin(2z))

r1(sin(3z)) === nothing

r1(sin(2*(w-z)))

r1(sin(2*(w+z)*(α+β))) === nothing

