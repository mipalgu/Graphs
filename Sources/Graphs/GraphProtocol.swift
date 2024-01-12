public protocol GraphProtocol: AnyObject {

    associatedtype Node: NodeProtocol

    associatedtype Connection: ConnectionProtocol where Connection.Node == Node

    associatedtype NodeCollection: Collection where NodeCollection.Iterator.Element == Node

    associatedtype ConnectionCollection: Collection where ConnectionCollection.Iterator.Element == Connection

    var connections: ConnectionCollection { get }

    var nodes: NodeCollection { get }

    func node(_: Node.ID) -> Node?

    func nodes(after node: Node.ID) -> NodeCollection.SubSequence

}

public extension GraphProtocol {

    func layout() {
        let gravityConstant = Point2D(-1.1)
        let forceConstant = Point2D(1000)
        let inverseForceConstant = Point2D(1.0) / forceConstant
        for node in nodes {
            node.force = node.point * gravityConstant
        }
        for node in nodes {
            let point = node.point
            for other in nodes(after: node.id) where other.id != node.id {
                let diff = other.point - point
                let mag = diff.magnitude
                let relativeForce = (diff / (mag * mag)) * forceConstant
                node.force += relativeForce * -1
                other.force += relativeForce
            }
        }
        for connection in connections {
            guard let lhs = self.node(connection.lhs), let rhs = self.node(connection.rhs) else {
                continue
            }
            let distance = lhs.point - rhs.point
            let diff = distance.magnitude - connection.distance
            if abs(diff) < 0.1 {
                continue
            }
            lhs.force += inverseForceConstant * diff
            rhs.force -= inverseForceConstant * diff
        }
    }

}
