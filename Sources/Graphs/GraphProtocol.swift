public protocol GraphProtocol {

    associatedtype Node: NodeProtocol

    associatedtype Connection: ConnectionProtocol where Connection.Node == Node

    associatedtype NodeCollection: Collection where NodeCollection.Iterator.Element == Node

    associatedtype ConnectionCollection: Collection where ConnectionCollection.Iterator.Element == Connection

    var connections: ConnectionCollection { get }

    var nodes: NodeCollection { get }

    func node(_: Node.ID) -> Node?

    func nodes(after node: Node.ID) -> NodeCollection.SubSequence?

    mutating func replace(node id: Node.ID, with node: Node)

}

public extension GraphProtocol {

    mutating func simulate(gravityConstant: Point2D = -1.1, forceConstant: Point2D = 1000) {
        //let inverseForceConstant = Point2D(1.0) / forceConstant
        for var node in nodes {
            node.force = node.point * gravityConstant
            replace(node: node.id, with: node)
        }
        for var node in nodes {
            let point = node.point
            guard let otherNodes = nodes(after: node.id) else {
                continue
            }
            for var other in otherNodes where other.id != node.id {
                let diff = other.point - point
                let mag = diff.magnitude
                let relativeForce: Point2D = mag == 0 ? forceConstant : (diff / (mag * mag)) * forceConstant
                node.force += relativeForce * -1
                other.force += relativeForce
                replace(node: other.id, with: other)
            }
            replace(node: node.id, with: node)
        }
        for connection in connections {
            guard var lhs = self.node(connection.lhs), var rhs = self.node(connection.rhs) else {
                continue
            }
            let distance = lhs.point - rhs.point
            let diff = distance.magnitude - connection.distance
            if abs(diff) < 0.1 {
                continue
            }
            lhs.force -= distance
            rhs.force += distance
            replace(node: lhs.id, with: lhs)
            replace(node: rhs.id, with: rhs)
        }
        for var node in nodes {
            node.point += node.force / node.mass
            replace(node: node.id, with: node)
        }
    }

    mutating func layout(times: Int = 1, gravityConstant: Point2D = -1.1, forceConstant: Point2D = 1000) {
        for _ in 0..<times {
            simulate(gravityConstant: gravityConstant, forceConstant: forceConstant)
        }
    }

}
