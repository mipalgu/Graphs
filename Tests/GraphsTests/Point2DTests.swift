import Foundation
import XCTest

@testable import Graphs

final class Point2DTests: XCTestCase {

    func testInit() {
        let point2D = Point2D(x: 5, y: 6)
        XCTAssertEqual(point2D.x, 5)
        XCTAssertEqual(point2D.y, 6)
    }

    func testDefaultInit() {
        let point2D = Point2D()
        XCTAssertEqual(point2D.x, 0)
        XCTAssertEqual(point2D.y, 0)
    }

    func testGettersAndSetters() {
        var point2D = Point2D(x: 5, y: 6)
        XCTAssertEqual(point2D.x, 5)
        XCTAssertEqual(point2D.y, 6)
        point2D.x = 7
        XCTAssertEqual(point2D.x, 7)
        XCTAssertEqual(point2D.y, 6)
        point2D.y = 8
        XCTAssertEqual(point2D.x, 7)
        XCTAssertEqual(point2D.y, 8)
    }

    func testMagnitude() {
        XCTAssertEqual(Point2D(x: 3, y: 4).magnitude, 5)
    }

    func testEquality() {
        XCTAssertEqual(Point2D(x: 5, y: 6), Point2D(x: 5, y: 6))
        XCTAssertNotEqual(Point2D(x: 5, y: 6), Point2D(x: 5, y: 7))
        XCTAssertNotEqual(Point2D(x: 5, y: 6), Point2D(x: 6, y: 6))
    }

    func testHashable() {
        var collection: Set<Point2D> = []
        collection.insert(Point2D(x: 5, y: 6))
        XCTAssertEqual(collection.count, 1)
        collection.insert(Point2D(x: 5, y: 6))
        XCTAssertEqual(collection.count, 1)
        collection.insert(Point2D(x: 5, y: 7))
        XCTAssertEqual(collection.count, 2)
        collection.insert(Point2D(x: 6, y: 7))
        XCTAssertEqual(collection.count, 3)
    }

    func testCodable() throws {
        let point2D = Point2D(x: 5, y: 6)
        let data = try JSONEncoder().encode(point2D)
        let decodedPoint2D = try JSONDecoder().decode(Point2D.self, from: data)
        XCTAssertEqual(point2D, decodedPoint2D)
    }

    func testExpressibleByIntegerLiteral() {
        XCTAssertEqual(5, Point2D(x: 5, y: 5))
    }

    func testExpressibleByFloatLiteral() {
        XCTAssertEqual(5.5, Point2D(x: 5.5, y: 5.5))
    }

    func testInitFromSingleValue() {
        let point2D = Point2D(5)
        XCTAssertEqual(point2D.x, 5)
        XCTAssertEqual(point2D.y, 5)
    }

    func testInitFromNode() {
        let node = Node(mass: 5, x: 5, y: 6)
        let point2D = Point2D(node: node)
        XCTAssertEqual(point2D.x, 5)
        XCTAssertEqual(point2D.y, 6)
    }

    func testDistance() {
        let point2D = Point2D(x: 5, y: 6)
        let distance = point2D.distance(to: Point2D(x: 8, y: 10))
        XCTAssertEqual(distance, 5)
    }

    func testAddition() {
        let point2D = Point2D(x: 5, y: 6) + Point2D(x: 7, y: 8)
        XCTAssertEqual(point2D.x, 12)
        XCTAssertEqual(point2D.y, 14)
    }

    func testSubtraction() {
        let point2D = Point2D(x: 5, y: 6) - Point2D(x: 7, y: 4)
        XCTAssertEqual(point2D.x, -2)
        XCTAssertEqual(point2D.y, 2)
    }

    func testMultiplication() {
        let point2D = Point2D(x: 5, y: 6) * Point2D(x: 7, y: 4)
        XCTAssertEqual(point2D.x, 35)
        XCTAssertEqual(point2D.y, 24)
    }

    func testDivision() {
        let point2D = Point2D(x: 12, y: 6) / Point2D(x: 3, y: 2)
        XCTAssertEqual(point2D.x, 4)
        XCTAssertEqual(point2D.y, 3)
    }

    func testPlusEquals() {
        var point2D = Point2D(x: 5, y: 6)
        point2D += Point2D(x: 7, y: 8)
        XCTAssertEqual(point2D.x, 12)
        XCTAssertEqual(point2D.y, 14)
    }

    func testMinusEquals() {
        var point2D = Point2D(x: 5, y: 6)
        point2D -= Point2D(x: 7, y: 4)
        XCTAssertEqual(point2D.x, -2)
        XCTAssertEqual(point2D.y, 2)
    }

    func testMultiplyEquals() {
        var point2D = Point2D(x: 5, y: 6)
        point2D *= Point2D(x: 7, y: 4)
        XCTAssertEqual(point2D.x, 35)
        XCTAssertEqual(point2D.y, 24)
    }

    func testDivideEquals() {
        var point2D = Point2D(x: 12, y: 6)
        point2D /= Point2D(x: 3, y: 2)
        XCTAssertEqual(point2D.x, 4)
        XCTAssertEqual(point2D.y, 3)
    }

    func testAddValue() {
        let point2D = Point2D(x: 5, y: 6) + 7
        XCTAssertEqual(point2D.x, 12)
        XCTAssertEqual(point2D.y, 13)
    }

    func testSubtractValue() {
        let point2D = Point2D(x: 5, y: 6) - 7
        XCTAssertEqual(point2D.x, -2)
        XCTAssertEqual(point2D.y, -1)
    }

    func testMultiplyValue() {
        let point2D = Point2D(x: 5, y: 6) * 7
        XCTAssertEqual(point2D.x, 35)
        XCTAssertEqual(point2D.y, 42)
    }

    func testDivideValue() {
        let point2D = Point2D(x: 12, y: 6) / 3
        XCTAssertEqual(point2D.x, 4)
        XCTAssertEqual(point2D.y, 2)
    }

    func testPlusEqualsValue() {
        var point2D = Point2D(x: 5, y: 6)
        point2D += 7
        XCTAssertEqual(point2D.x, 12)
        XCTAssertEqual(point2D.y, 13)
    }

    func testSubtractEqualsValue() {
        var point2D = Point2D(x: 5, y: 6)
        point2D -= 7
        XCTAssertEqual(point2D.x, -2)
        XCTAssertEqual(point2D.y, -1)
    }

    func testMultiplyEqualsValue() {
        var point2D = Point2D(x: 5, y: 6)
        point2D *= 7
        XCTAssertEqual(point2D.x, 35)
        XCTAssertEqual(point2D.y, 42)
    }

    func testDivideEqualsValue() {
        var point2D = Point2D(x: 12, y: 6)
        point2D /= 3
        XCTAssertEqual(point2D.x, 4)
        XCTAssertEqual(point2D.y, 2)
    }

}
