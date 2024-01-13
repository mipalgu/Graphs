import XCTest

@testable import Graphs

/// Provides a common set of tests for all types that conform to
/// `GraphProtocol`.
class GraphProtocolTestCase<Graph: GraphProtocol>: XCTestCase {

    /// Checks that calling node(_:) returns a non-nil value for all nodes
    /// within the graph and nil for non-existent id's.
    func performNodeLookupTest(graph: Graph, next: (Graph.Node.ID) -> Graph.Node.ID) {
        for node in graph.nodes {
            let foundNode = graph.node(node.id)
            XCTAssertNotNil(foundNode)
            guard let foundNode = foundNode else {
                continue
            }
            XCTAssertEqual(node.id, foundNode.id)
        }
        let ids = Set(graph.nodes.map(\.id))
        var missingID: Graph.Node.ID?
        for id in ids {
            let newID = next(id)
            if !ids.contains(newID) {
                missingID = newID
                break
            }
        }
        XCTAssertNotNil(missingID, "Unable to calculate missing id.")
        guard let missingID = missingID else {
            return
        }
        XCTAssertNil(graph.node(missingID), "Graph contains a node that should not exist.")
    }

    /// Checks that calling nodes(after:) returns nil for a missing id.
    func performNodesAfterWithMissingID(graph: Graph, next: (Graph.Node.ID) -> Graph.Node.ID) {
        let ids = Set(graph.nodes.map(\.id))
        var missingID: Graph.Node.ID?
        for id in ids {
            let newID = next(id)
            if !ids.contains(newID) {
                missingID = newID
                break
            }
        }
        XCTAssertNotNil(missingID, "Unable to calculate missing id.")
        guard let missingID = missingID else {
            return
        }
        XCTAssertNil(graph.nodes(after: missingID), "nodes(after:) returns a non-nil value for missing id.")
    }

    /// Checks that calling nodes(after:) returns an empty collection for a
    /// graph containing only a single node.
    func performNodesAfterWithSingleNodeTest(graph: Graph) {
        let nodes = graph.nodes
        XCTAssertEqual(nodes.count, 1)
        guard let first = nodes.first else {
            XCTFail("Graph contains no nodes.")
            return
        }
        guard let afterNodes = graph.nodes(after: first.id) else {
            XCTFail("Expected graph to return an empty collection, not nil.")
            return
        }
        XCTAssertTrue(afterNodes.isEmpty, "Expected graph to have no nodes after the first: \(afterNodes)")
    }

    /// Checks that calling nodes(after:) returns a correct collection
    /// containing all nodes ordered after the lookup node.
    func performNodesAfterTest(graph: Graph) {
        let nodes = graph.nodes
        guard let first = nodes.first else {
            XCTFail("Graph contains no nodes.")
            return
        }
        guard let afterNodes = graph.nodes(after: first.id) else {
            XCTFail("Expected graph to have nodes after the first.")
            return
        }
        var ids = Set(nodes.dropFirst().map(\.id))
        var foundIds = Set<Graph.Node.ID>(minimumCapacity: ids.count)
        for node in afterNodes {
            XCTAssertFalse(foundIds.contains(node.id), "Same node found twice in collection.")
            foundIds.insert(node.id)
            XCTAssertTrue(ids.contains(node.id), "Did not find node in collection.")
            ids.remove(node.id)
        }
        XCTAssertTrue(ids.isEmpty, "Did not find all nodes in collection.")
    }

    /// A general test that determines if it is possible to layout the graph
    /// so that the distances between nodes is within acceptable bounds.
    func performLayoutProducesABalancedGraphTest(graph: inout Graph) {
        graph.layout(times: graph.nodes.count * 10)
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

    /// Checks that calling replace(node:with:) updates the graph correctly.
    func performReplaceTest(graph: inout Graph, missing: Graph.Node, next: (Graph.Node.ID) -> Graph.Node.ID) {
        let nodes = graph.nodes
        let initialCount = nodes.count
        guard let first = nodes.first else {
            XCTFail("Graph contains no nodes.")
            return
        }
        let ids = Set(nodes.map(\.id))
        XCTAssertEqual(ids.count, nodes.count)
        var missingID: Graph.Node.ID?
        for id in ids {
            let newID = next(id)
            if !ids.contains(newID) {
                missingID = newID
                break
            }
        }
        XCTAssertNotNil(missingID, "Unable to calculate missing id.")
        guard let missingID = missingID else {
            return
        }
        XCTAssertNil(graph.node(missingID), "Graph contains a node that should not exist.")
        graph.replace(node: missingID, with: missing)
        let afterIds = Set(graph.nodes.map(\.id))
        XCTAssertEqual(ids, afterIds)
        XCTAssertEqual(afterIds.count, graph.nodes.count)
        var missing = missing
        missing.x = first.x &+ 1
        graph.replace(node: first.id, with: missing)
        guard let firstAfter = graph.node(first.id) else {
            XCTFail("Graph does not contain the updated node.")
            return
        }
        XCTAssertEqual(firstAfter.mass, first.mass)
        XCTAssertEqual(firstAfter.force, first.force)
        XCTAssertNotEqual(firstAfter.x, first.x)
        XCTAssertEqual(firstAfter.y, first.y)
        XCTAssertEqual(firstAfter.id, missing.id)
        XCTAssertEqual(firstAfter.mass, missing.mass)
        XCTAssertEqual(firstAfter.force, missing.force)
        XCTAssertEqual(firstAfter.x, missing.x)
        XCTAssertEqual(firstAfter.y, missing.y)
        let endCount = graph.nodes.count
        XCTAssertEqual(initialCount, endCount)
    }

}

/// Convenience methods for testing graphs with numeric node ids.
extension GraphProtocolTestCase where Graph.Node.ID: Numeric, Graph.Node.ID: AdditiveArithmetic {

    /// Checks that calling nodes(after:) returns nil for a missing id.
    func performNodesAfterWithMissingID(graph: Graph) {
        performNodesAfterWithMissingID(graph: graph) { $0 + 1 }
    }

    /// Checks that calling node(_:) returns a non-nil value for all nodes
    /// within the graph and nil for non-existent id's.
    func performNodeLookupTest(graph: Graph) {
        performNodeLookupTest(graph: graph) { $0 + 1 }
    }

}
