import XCTest

@testable import Graphs

final class AnyNodeTests: NodeProtocolTestCase<AnyNode<ObjectIdentifier>> {

    func testInit() {
        let rawNode = Node(mass: 5)
        let node = AnyNode(rawNode)
        XCTAssertEqual(node.id, rawNode.id)
        XCTAssertEqual(node.mass, 5)
        XCTAssertEqual(node.force, Point2D())
        XCTAssertEqual(node.x, 0)
        XCTAssertEqual(node.y, 0)
        node.force = Point2D(x: 6, y: 7)
        node.x = 8
        node.y = 9
        XCTAssertEqual(rawNode.force, Point2D(x: 6, y: 7))
        XCTAssertEqual(rawNode.x, 8)
        XCTAssertEqual(rawNode.y, 9)
        rawNode.force = Point2D(x: 20, y: 21)
        rawNode.x = 22
        rawNode.y = 23
        XCTAssertEqual(node.force, Point2D(x: 20, y: 21))
        XCTAssertEqual(node.x, 22)
        XCTAssertEqual(node.y, 23)
    }

    func testGettersAndSetters() {
        let node = Node(mass: 5, force: Point2D(x: 6, y: 7), x: 8, y: 9)
        performGettersAndSettersTest(node: AnyNode(node), mass: 5)
    }

    func testPoint() {
        let node = Node(mass: 5, x: 5, y: 6)
        performPointTest(node: AnyNode(node), other: AnyNode(Node(mass: 5)))
    }

    func testDistance() {
        let node = Node(mass: 5, x: 5, y: 6)
        performDistanceTest(node: AnyNode(node), other: AnyNode(Node(mass: 5)))
    }

}
