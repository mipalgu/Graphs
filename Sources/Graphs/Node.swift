/// A node that is stored on the heap for use when the graph is stored in
/// memory, and not within some external data store.
public final class Node: NodeProtocol, CustomStringConvertible {

    /// The mass of this node.
    ///
    /// This should be a non-zero number. If you don't know what values to use
    /// for a mass, generally what is important is the relation between the
    /// mass of the nodes within the same graph. In other words, simply setting
    /// a mass of 1 for all nodes means that each node will be effected by the
    /// same force equally.
    public let mass: Double

    /// The force currently being applied to this node.
    ///
    /// This value is used by force-directed graph algorithms to keep track of
    /// the forces on each node within the graph. Typically, you initially set
    /// this value to zero and simply let the graph algorithms set appropriate
    /// values.
    public var force: Point2D

    /// The two-dimensional x coordinate of this node on a hypothetical canvas.
    public var x: Int

    /// The two-dimensional y coordinate of this node on a hypothetical canvas.
    public var y: Int

    /// A textual representation of this node.
    public var description: String {
        "Node(mass: \(mass), force: \(force), x: \(x), y: \(y))"
    }

    /// Creates a new node.
    ///
    /// - Parameters:
    ///   - mass: The mass of this node.
    ///   - force: The force currently being applied to this node.
    ///   - x: The two-dimensional x coordinate of this node on a hypothetical
    ///     canvas.
    ///   - y: The two-dimensional y coordinate of this node on a hypothetical
    ///     canvas.
    public init(mass: Double, force: Point2D = 0, x: Int = 0, y: Int = 0) {
        self.mass = mass
        self.force = force
        self.x = x
        self.y = y
    }

}
