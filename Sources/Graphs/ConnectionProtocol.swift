/// Defines an attractive force between two nodes within the same graph.
///
/// This is used by force-directed graph algorithms to move related nodes
/// closer together. The connection is defined as a relationship between two
/// nodes and the ideal distance that those two nodes should be from each other.
public protocol ConnectionProtocol {

    /// The type of nodes that are being connected by this connection.
    associatedtype Node: NodeProtocol

    /// The left-hand-side of the connection.
    ///
    /// This has no meaning in the context of force-directed graph algorithms
    /// and simply serves as a way to identify one of the nodes being connected.
    var lhs: Node.ID { get }

    /// The right-hand-side of the connection.
    ///
    /// This has no meaning in the context of force-directed graph algorithms
    /// and simply serves as a way to identify on of the nodes being connected.
    var rhs: Node.ID { get }

    /// The ideal distance between the two nodes.
    var distance: Double { get }

}
