module Graphtivity {
  use List;

  class Vertex {
    var id: int;
    var msg : string;
  }

  class Edge {
    var from : shared Vertex;
    var to : shared Vertex;
    var msg : string;
  }

  class Graph {
    var name = "G";
    var vertices : list(shared Vertex);
    var edges : list(shared Edge);

    proc addNode(id:int, msg:string) : shared Vertex {
      var v = new shared Vertex(id, msg);
      vertices.append(v);
      return vertices.last();
    }

    proc addEdge(node1: shared Vertex, node2: shared Vertex, msg:string) {
      var e = new shared Edge(node1, node2, msg);
      edges.append(e);
    }

    proc deleteEdge(from: Vertex, to: Vertex) {
      for e in edges {
        if e!.from == from && e!.to == to {
          // prune the list we're iterating over?!?!?! yikes!
          edges.remove(e);
        }
      }
    }

    proc updateEdgeMsg(from: Vertex, to: Vertex, msg: string) {
      for e in edges {
        if e!.from == from && e!.to == to {
          e!.msg = msg;
        }
      }
    }

    proc toDot() {
      writeln("digraph ", this.name, " {");
      for v in vertices {
        writeln("  ", v.id, " [label=\"", v.msg, "\"];");
      }
      for e in edges {
        writeln("  ", e.from.id, " -> ", e.to.id, " [label=\"", e.msg, "\"];");
      }
      writeln("}");
    }
  }

  proc main() {
    var graph = new Graph("G1");

    var nodeID1 = graph.addNode(1, "node1");
    var nodeID2 = graph.addNode(2, "node2");
    var nodeID3 = graph.addNode(3, "node3");


    graph.addEdge(nodeID1, nodeID2, "edge1");
    graph.addEdge(nodeID2, nodeID1, "edge2");
    graph.toDot();

    // graph.deleteEdge(nodeID1, nodeID2);
    // graph.toDot();

    nodeID1.msg = "node1 changed";
    graph.toDot();

    graph.updateEdgeMsg(nodeID2, nodeID1, "edge2 updated");
    graph.toDot();
  }

}


