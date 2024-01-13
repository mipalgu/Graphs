import XCTest

@testable import Graphs

final class NodeTests: NodeProtocolTestCase<Node> {

    func testInit() {
        let node = Node(mass: 5, force: Point2D(x: 6, y: 7), x: 8, y: 9)
        XCTAssertEqual(node.mass, 5)
        XCTAssertEqual(node.force, Point2D(x: 6, y: 7))
        XCTAssertEqual(node.x, 8)
        XCTAssertEqual(node.y, 9)
    }

    func testDefaultInit() {
        let node = Node(mass: 0)
        XCTAssertEqual(node.mass, 0)
        XCTAssertEqual(node.force, Point2D())
        XCTAssertEqual(node.x, 0)
        XCTAssertEqual(node.y, 0)
    }

    func testDescription() {
        let node = Node(mass: 5, force: Point2D(x: 6, y: 7), x: 8, y: 9)
        XCTAssertEqual(node.description, "Node(mass: 5.0, force: Point2D(x: 6.0, y: 7.0), x: 8, y: 9)")
    }

    func testGettersAndSetters() {
        let node = Node(mass: 5, force: Point2D(x: 6, y: 7), x: 8, y: 9)
        performGettersAndSettersTest(node: node, mass: 5)
    }

    func testPoint() {
        let node = Node(mass: 5, x: 5, y: 6)
        performPointTest(node: node, other: Node(mass: 5))
    }

    func testDistance() {
        let node = Node(mass: 5, x: 5, y: 6)
        performDistanceTest(node: node, other: Node(mass: 5))
    }

}
