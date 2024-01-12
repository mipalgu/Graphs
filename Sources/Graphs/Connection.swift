/// A connection that is stored on the heap for use when the graph is stored in
/// memory, and not within some external data store.
public final class Connection<Node: NodeProtocol>: ConnectionProtocol {

    /// The left-hand-side of the connection.
    ///
    /// This has no meaning in the context of force-directed graph algorithms
    /// and simply serves as a way to identify one of the nodes being connected.
    public let lhs: Node.ID

    /// The right-hand-side of the connection.
    ///
    /// This has no meaning in the context of force-directed graph algorithms
    /// and simply serves as a way to identify on of the nodes being connected.
    public let rhs: Node.ID

    /// The ideal distance between the two nodes.
    public let distance: Double

    /// Creates a new connection.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand-side of the connection.
    ///   - rhs: The right-hand-side of the connection.
    ///   - distance: The ideal distance between the two nodes.
    public init(lhs: Node.ID, rhs: Node.ID, distance: Double) {
        self.lhs = lhs
        self.rhs = rhs
        self.distance = distance
    }

}
