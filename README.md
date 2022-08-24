## Chapel Class Usage Hackathon

The goal is to experiment with different ways one might write a DS with
potential cycles, using Chapel.

### API

- `var graph = new Graph();`
- `nodeId1 = graph.addNode(val1); nodeId2 = graph.addNode(val2);`
- `graph.addEdge(nodeId1, nodeId2, val);`
- `graph.toDot();`  FIXME: show an example of what that looks like