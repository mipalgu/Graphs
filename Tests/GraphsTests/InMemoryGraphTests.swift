import XCTest

@testable import Graphs

final class InMemoryGraphTests: XCTestCase {

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

    func testLayoutProducesABalancedGraph() throws {
        graph.layout(times: 10)
        for node in graph.nodes {
            guard let otherNodes = graph.nodes(after: node.id) else {
                XCTFail("Unable to fetch other nodes.")
                return
            }
            for other in otherNodes {
                XCTAssertLessThan(abs(node.distance(to: other)), 50)
            }
        }
    }
}
