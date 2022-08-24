module Graphtivity {
  use List;

  class Vertex {
    var id: int;
    var msg : string;
  }

  class Edge {
    var from : borrowed Vertex;
    var to : borrowed Vertex;
    var msg : string;
  }

  class Graph {
    var vertices : list(owned Vertex);
    var edges : list(owned Edge?);

    proc addNode(id:int, msg:string) : borrowed Vertex {
      var v = new owned Vertex(id, msg);
      vertices.append(v);
      return vertices.last().borrow();
    }

    proc addEdge(node1: borrowed Vertex, node2: borrowed Vertex, msg:string) {
      var e = new owned Edge(node1, node2, msg);
      edges.append(e);
    }

    proc deleteEdge(from: Vertex, to: Vertex) {
      for e in edges {
        if e!.from == from && e!.to == to {
          edges.remove(e);
        }
      }
    }

    proc toDot() {
      writeln("digraph G {");
      for v in vertices {
        writeln("  ", v.id, " [label=\"", v.msg, "\"];");
      }
      for e in edges {
        writeln("  ", e!.from.id, " -> ", e!.to.id, " [label=\"", e!.msg, "\"];");
      }
      writeln("}");
    }
  }

  proc main() {
    var graph = new Graph();
    var nodeID1 = graph.addNode(1,"node1");
    var nodeID2 = graph.addNode(2,"node2");
    graph.addEdge(nodeID1, nodeID2, "edge1");
    graph.addEdge(nodeID2, nodeID1, "edge2");
    graph.toDot();
    graph.deleteEdge(nodeID1, nodeID2);
    graph.toDot();
  }

}


