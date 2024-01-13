import XCTest

@testable import Graphs

final class InMemoryGraphTests: GraphProtocolTestCase<InMemoryGraph<Node, Connection<Node>>> {

    var graph: InMemoryGraph<Node, Connection<Node>>!

    override func setUp() {
        var nodes: [Node.ID: Node] = Dictionary(minimumCapacity: 100)
        let node0 = Node(mass: 10)
        let node1 = Node(mass: 10)
        let node2 = Node(mass: 10)
        let node3 = Node(mass: 10)
        nodes[node0.id] = node0
        nodes[node1.id] = node1
        nodes[node2.id] = node2
        nodes[node3.id] = node3
        var connections: [Connection<Node>] = []
        connections.reserveCapacity(100)
        connections.append(Connection(lhs: node0.id, rhs: node1.id, distance: 10))
        connections.append(Connection(lhs: node0.id, rhs: node2.id, distance: 10))
        connections.append(Connection(lhs: node0.id, rhs: node3.id, distance: 10))
        connections.append(Connection(lhs: node1.id, rhs: node2.id, distance: 10))
        connections.append(Connection(lhs: node1.id, rhs: node3.id, distance: 10))
        connections.append(Connection(lhs: node2.id, rhs: node3.id, distance: 10))
        self.graph = InMemoryGraph(nodes: nodes, connections: connections)
    }

    func testNodeLookup() {
        performNodeLookupTest(graph: graph) {
            unsafeBitCast(UInt(bitPattern: $0) &+ 1, to: ObjectIdentifier.self)
        }
    }

    func testNodesAfterWithSingleNode() {
        let node = Node(mass: 10)
        let smallGraph = InMemoryGraph<Node, Connection<Node>>(nodes: [node.id: node], connections: [])
        performNodesAfterWithSingleNodeTest(graph: smallGraph)
    }

    func testNodesAfter() {
        performNodesAfterTest(graph: graph)
    }

    func testNodesAfterWithMissingID() {
        performNodesAfterWithMissingID(graph: graph) {
            unsafeBitCast(UInt(bitPattern: $0) &+ 1, to: ObjectIdentifier.self)
        }
    }

    func testReplace() {
        let missing = Node(mass: 10)
        performReplaceTest(graph: &graph, missing: missing) {
            unsafeBitCast(UInt(bitPattern: $0) &+ 1, to: ObjectIdentifier.self)
        }
    }

    func testLayoutProducesABalancedGraph() {
        performLayoutProducesABalancedGraphTest(graph: &graph)
    }
}
