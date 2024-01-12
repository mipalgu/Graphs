public final class Connection<Node: NodeProtocol>: ConnectionProtocol {

    public let lhs: Node.ID

    public let rhs: Node.ID

    public let distance: Double

    public init(lhs: Node.ID, rhs: Node.ID, distance: Double) {
        self.lhs = lhs
        self.rhs = rhs
        self.distance = distance
    }

}
