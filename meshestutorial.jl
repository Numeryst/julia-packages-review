using Meshes
import CairoMakie as Mke

Point(0.0, 1.0) # double precision as expected

Point(0f0, 1f0) # single precision as expected

Point(0, 0) # Integer is converted to Float64 by design

Point(1.0, 2.0, 3.0) # double precision as expected

Point(1f0, 2f0, 3f0) # single precision as expected

Point(1, 2, 3) # Integer is converted to Float64 by design

A = Point(1.0, 1.0)
B = Point(3.0, 3.0)
B - A

to(A) + to(B)

A + Vec(1, 1)

coords(A)

b = Box((0.0, 0.0, 0.0), (1.0, 1.0, 1.0))

viz(b)

s = Sphere((0.0, 0.0, 0.0), 1.0)

viz(s)

extrema(b)

centroid(s), radius(s)

measure(b)

vs = sample(s, RegularSampling(10)) # 10 points over the sphere

viz(collect(vs))

# Polytopes

t = Triangle((0.0, 0.0), (1.0, 0.0), (0.0, 1.0))

viz(t)

measure(t)

measure(t) == area(t)

p = Point(0.5, 0.0)

p ∈ t # type p \in t

s1 = Segment((0.0, 0.0), (1.0, 0.0))
s2 = Segment((0.5, 0.0), (2.0, 0.0))

s1 ∩ s2 # type s1 \cap s2

p = PolyArea((0,0), (2,0), (2,2), (1,3), (0,2))

viz(p)

orientation(p)

r = rings(p) |> first

reverse(r)

v = vertices(r)

v[1:10]

angles(r) * 180 / pi

angles(reverse(r)) * 180 / pi

innerangles(r) * 180 / pi

issimple(p)

grid = CartesianGrid(100, 100)

viz(grid, showsegments = true)

@allocated CartesianGrid(10000, 10000, 10000)

collect(grid)

points = [(0,0), (1,0), (0,1), (1,1), (0.25,0.5), (0.75,0.5)]
tris  = connect.([(1,5,3), (4,6,2)], Triangle)
quads = connect.([(1,2,6,5), (4,3,5,6)], Quadrangle)
mesh = SimpleMesh(points, [tris; quads])

viz(mesh, showsegments = true)

collect(mesh)
