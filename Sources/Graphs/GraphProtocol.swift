public protocol GraphProtocol: AnyObject {

    associatedtype Node: NodeProtocol

    associatedtype Connection: ConnectionProtocol where Connection.Node == Node

    associatedtype NodeSequence: Sequence where NodeSequence.Iterator.Element == Node

    associatedtype ConnectionSequence: Sequence where ConnectionSequence.Iterator.Element == Connection

    var connections: ConnectionSequence { get }

    var nodes: NodeSequence { get }

    func manipulate(_ change: (inout Node) throws -> Void) rethrows

    func node(_: Node.ID) -> Node?

    func nodes(after node: Node.ID) -> NodeSequence

    func replace(node id: Node.ID, with node: Node)

}

public extension GraphProtocol {

    func layout() {
        let gravityConstant = Point2D(-1.1)
        let forceConstant = Point2D(1000)
        manipulate { node in
            node.force = node.point * gravityConstant
        }
        manipulate { node in
            let point = node.point
            for var other in nodes(after: node.id) where other.id != node.id {
                let diff = other.point - point
                let mag = diff.magnitude
                let relativeForce = (diff / (mag * mag)) * forceConstant
                node.force += relativeForce * -1
                other.force += relativeForce
                replace(node: other.id, with: other)
            }
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
            lhs.force += forceConstant * diff
            rhs.force -= forceConstant * diff
            replace(node: lhs.id, with: lhs)
            replace(node: rhs.id, with: rhs)
        }
    }

}
