/// Defines a single node within a graph.
///
/// A node within a graph is a single vertex that may be connected to other
/// nodes within the graph. When laying out the graph, a force is applied to
/// the mass of the node to calculate the nodes velocity. The velocity is then
/// applied to the x and y coordinates of the node.
public protocol NodeProtocol: Identifiable {

    /// The mass of this node.
    ///
    /// This should be a non-zero number. If you don't know what values to use
    /// for a mass, generally what is important is the relation between the
    /// mass of the nodes within the same graph. In other words, simply setting
    /// a mass of 1 for all nodes means that each node will be effected by the
    /// same force equally.
    var mass: Double { get }

    /// The force currently being applied to this node.
    ///
    /// This value is used by force-directed graph algorithms to keep track of
    /// the forces on each node within the graph. Typically, you initially set
    /// this value to zero and simply let the graph algorithms set appropriate
    /// values.
    var force: Point2D { get set }

    /// The two-dimensional x coordinate of this node on a hypothetical canvas.
    var x: Int { get set }

    /// The two-dimensional y coordinate of this node on a hypothetical canvas.
    var y: Int { get set }

}

/// Contains default implementations for conforming types.
public extension NodeProtocol {

    /// Treat the ``x`` and ``y`` coordinates as a single ``Point2D`` vector.
    var point: Point2D {
        get {
            Point2D(node: self)
        } set {
            let newXValue = newValue.x.rounded(.toNearestOrAwayFromZero)
            if newXValue < Double(Int.min) {
                self.x = Int.min
            } else if newXValue > Double(Int.max) {
                self.x = Int.max
            } else {
                self.x = Int(newXValue)
            }
            let newYValue = newValue.y.rounded(.toNearestOrAwayFromZero)
            if newYValue < Double(Int.min) {
                self.y = Int.min
            } else if newYValue > Double(Int.max) {
                self.y = Int.max
            } else {
                self.y = Int(newYValue)
            }
        }
    }

    /// Calculate the distance from this node to another node of the same type.
    ///
    /// - Parameter other: The other node within the same graph.
    ///
    /// - Returns: The magnitude of applying `other.point - self.point`.
    func distance(to other: Self) -> Double {
        point.distance(to: other.point)
    }

}
