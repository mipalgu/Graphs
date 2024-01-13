import XCTest

@testable import Graphs

final class ConnectionTests: ConnectionProtocolTestCase {

    func testInit() {
        let lhs = Node(mass: 5)
        let rhs = Node(mass: 6)
        let connection = Connection<Node>(lhs: lhs.id, rhs: rhs.id, distance: 10)
        XCTAssertEqual(connection.lhs, lhs.id)
        XCTAssertEqual(connection.rhs, rhs.id)
        XCTAssertEqual(connection.distance, 10)
    }

}
