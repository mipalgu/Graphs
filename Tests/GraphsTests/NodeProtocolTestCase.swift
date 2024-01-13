import XCTest

@testable import Graphs

class NodeProtocolTestCase<Node: NodeProtocol>: XCTestCase {

    func performGettersAndSettersTest(node: Node, mass: Double) {
        XCTAssertEqual(node.mass, mass)
        let force = Point2D(x: node.force.x + 1, y: node.force.y + 1)
        let x = node.x + 1
        let y = node.y + 1
        var node = node
        node.force = force
        node.x = x
        node.y = y
        XCTAssertEqual(node.force, force)
        XCTAssertEqual(node.x, x)
        XCTAssertEqual(node.y, y)
    }

    func performPointTest(node: Node, other: Node) {
        var point = node.point
        XCTAssertEqual(point.x, Double(node.x))
        XCTAssertEqual(point.y, Double(node.y))
        point.x = 1.5
        point.y = -1.5
        var other = other
        other.point = point
        XCTAssertEqual(other.x, 2)
        XCTAssertEqual(other.y, -2)
    }

    func performDistanceTest(node: Node, other: Node) {
        var other = other
        other.x = node.x + 3
        other.y = node.y + 4
        XCTAssertEqual(node.distance(to: other), 5)
    }

}
