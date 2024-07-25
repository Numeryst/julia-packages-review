using Graphs
using GraphPlot

G₁ = Graph(3) # graph with 3 vertices

# make a triangle
add_edge!(G₁, 1, 2)
add_edge!(G₁, 1, 3)
add_edge!(G₁, 2, 3)

gplot(G₁, nodelabel=1:3)

A = [
    0 1 1
    1 0 1
    1 1 0
]

G₂ = Graph(A)

@assert G₁ == G₂

G = Graph(5, 6)

gplot(G)

Graph(3, 4)

G = Graph(5, 10)

gplot(G)

G = DiGraph(3,3)

gplot(G)

for shape in ["petersen","moebiuskantor"]
    G = smallgraph(shape)
    display(gplot(G))
end

G = CliqueGraph(3,4)

gplot(G)

G = smallgraph("house")
gplot(G)


nvertices = nv(G) # number of vertices
nedges = ne(G)    # number of edges

gplot(G, nodelabel=1:nvertices, edgelabel=1:nedges, edgelabelc="blue")

for v in vertices(G)
    println("vertex $v")
end

for e in edges(G)
    u, v = src(e), dst(e)
    println("edge $u - $v")
end

adjacency_matrix(G)

incidence_matrix(G)

laplacian_matrix(G)

G = Graph()
add_vertices!(G, 5)
add_edge!(G, 1, 2)
add_edge!(G, 1, 3)
add_edge!(G, 2, 4)
add_edge!(G, 3, 4)
add_edge!(G, 3, 5)
add_edge!(G, 4, 5)

gplot(G, nodelabel=1:nv(G), edgelabel=1:ne(G))

add_vertex!(G)
add_edge!(G, 5, 6)

gplot(G, nodelabel=1:nv(G), edgelabel=1:ne(G))

rem_vertex!(G, 1)

gplot(G, nodelabel=1:nv(G), edgelabel=1:ne(G))


😆 = Graph(4)
add_edge!(😆, 1, 2)
add_edge!(😆, 1, 3)
add_edge!(😆, 2, 4)
add_edge!(😆, 3, 4)

gplot(😆)

skeleton = Graph(11)
add_edge!(skeleton, 1, 2)
add_edge!(skeleton, 2, 3)
add_edge!(skeleton, 3, 4)
add_edge!(skeleton, 4, 5)
add_edge!(skeleton, 3, 6)
add_edge!(skeleton, 3, 7)
add_edge!(skeleton, 3, 8)
add_edge!(skeleton, 3, 9)
add_edge!(skeleton, 9, 10)
add_edge!(skeleton, 9, 11)

gplot(cartesian_product(😆, skeleton))