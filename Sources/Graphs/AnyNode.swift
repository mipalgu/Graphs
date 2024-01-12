/// A type-erased wrapper around an underlying type conforming to
/// ``NodeProtocol``.
public final class AnyNode<ID: Hashable>: NodeProtocol {

    /// The function that fetches the id from base.
    private let _id: () -> ID

    /// The function that fetches the mass from base.
    private let _mass: () -> Double

    /// The function that fetches the force from base.
    private let _force: () -> Point2D

    /// The function that sets the force on base.
    private let _setForce: (Point2D) -> Void

    /// The function that fetches the x coordinate from base.
    private let _x: () -> Int

    /// The function that sets the x coordinate on base.
    private let _setX: (Int) -> Void

    /// The function that fetches the y coordinate from base.
    private let _y: () -> Int

    /// The function that sets the y coordinate on base.
    private let _setY: (Int) -> Void

    /// The unique identifier that distinguishes this node from other nodes
    /// within the same graph.
    public var id: ID {
        _id()
    }

    /// The mass of this node.
    ///
    /// This should be a non-zero number. If you don't know what values to use
    /// for a mass, generally what is important is the relation between the
    /// mass of the nodes within the same graph. In other words, simply setting
    /// a mass of 1 for all nodes means that each node will be effected by the
    /// same force equally.
    public var mass: Double {
        _mass()
    }

    /// The force currently being applied to this node.
    ///
    /// This value is used by force-directed graph algorithms to keep track of
    /// the forces on each node within the graph. Typically, you initially set
    /// this value to zero and simply let the graph algorithms set appropriate
    /// values.
    public var force: Point2D {
        get {
            _force()
        } set {
            _setForce(newValue)
        }
    }

    /// The two-dimensional x coordinate of this node on a hypothetical canvas.
    public var x: Int {
        get {
            _x()
        } set {
            _setX(newValue)
        }
    }

    /// The two-dimensional y coordinate of this node on a hypothetical canvas.
    public var y: Int {
        get {
            _y()
        } set {
            _setY(newValue)
        }
    }

    /// Create a new type-erased node from the given node.
    ///
    /// - Parameter base: The node to type-erase.
    public init<Base: NodeProtocol>(_ base: Base) where Base.ID == ID {
        var base = base
        self._id = { base.id }
        self._mass = { base.mass }
        self._force = { base.force }
        self._setForce = { base.force = $0 }
        self._x = { base.x }
        self._setX = { base.x = $0 }
        self._y = { base.y }
        self._setY = { base.y = $0 }
    }

}
