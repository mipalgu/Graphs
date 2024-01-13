/// A two-dimensional point.
///
/// This is used by force-directed graph algorithms to perform calculations
/// utilising 2D vectors.
public struct Point2D: Hashable, Codable, Sendable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {

    /// The x coordinate of this point.
    public var x: Double

    /// The y coordinate of this point.
    public var y: Double

    /// Calculates the magnitude of this point by performing the usual
    /// `sqrt(x ^ 2 + y ^ 2)`.
    public var magnitude: Double {
        (x * x + y * y).squareRoot()
    }

    /// Create a new point.
    ///
    /// - Parameter x: The x coordinate of the point.
    /// - Parameter y: The y coordinate of the point.
    public init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }

    /// Create a new point.
    ///
    /// - Parameter value: The value to set both x and y to.
    public init(_ value: Double) {
        self.init(x: value, y: value)
    }

    /// Create a new point from a node.
    ///
    /// - Parameter node: The node to create a point from.
    public init<Node: NodeProtocol>(node: Node) {
        self.init(x: Double(node.x), y: Double(node.y))
    }

    /// Create a new point from an integer literal.
    ///
    /// Bpth x and y of the new point will have the value of the integer
    /// literal.
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Double(value))
    }

    /// Create a new point from a float literal.
    ///
    /// Bpth x and y of the new point will have the value of the float literal.
    public init(floatLiteral value: FloatLiteralType) {
        self.init(Double(value))
    }

    /// Add each component of two points together.
    ///
    /// - Parameter lhs: The first point.
    ///
    /// - Parameter rhs: The second point.
    ///
    /// - Returns: The sum of the two points.
    public static func + (lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// Subtract each component of two points together.
    ///
    /// - Parameter lhs: The first point.
    ///
    /// - Parameter rhs: The second point.
    ///
    /// - Returns: The difference of the two points.
    public static func - (lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /// Multiply each component of two points together.
    ///
    /// - Parameter lhs: The first point.
    ///
    /// - Parameter rhs: The second point.
    ///
    /// - Returns: The product of the two points.
    public static func * (lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }

    /// Divide each component of two points together.
    ///
    /// - Parameter lhs: The first point.
    ///
    /// - Parameter rhs: The second point.
    ///
    /// - Returns: The quotient of the two points.
    public static func / (lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }

    /// Add the x and y values of one point to the x and y values of another.
    ///
    /// - Parameter lhs: The first point which is mutated with the result of the
    ///   addition.
    ///
    /// - Parameter rhs: The second point.
    public static func += (lhs: inout Point2D, rhs: Point2D) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }

    /// Subtract the x and y values of one point from the x and y values of
    /// another.
    ///
    /// - Parameter lhs: The first point which is mutated with the result of the
    ///   subtraction.
    ///
    /// - Parameter rhs: The second point.
    public static func -= (lhs: inout Point2D, rhs: Point2D) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }

    /// Multiply the x and y values of one point by the x and y values of
    /// another.
    ///
    /// - Parameter lhs: The first point which is mutated with the result of the
    ///   multiplication.
    ///
    /// - Parameter rhs: The second point.
    public static func *= (lhs: inout Point2D, rhs: Point2D) {
        lhs.x *= rhs.x
        lhs.y *= rhs.y
    }

    /// Divide the x and y values of one point by the x and y values of
    /// another.
    ///
    /// - Parameter lhs: The first point which is mutated with the result of the
    ///   division.
    ///
    /// - Parameter rhs: The second point.
    public static func /= (lhs: inout Point2D, rhs: Point2D) {
        lhs.x /= rhs.x
        lhs.y /= rhs.y
    }

    /// Calculates the distance between two points.
    ///
    /// - Parameter other: The other point.
    ///
    /// - Returns: The distance between the two points.
    public func distance(to other: Point2D) -> Double {
        (other - self).magnitude
    }

}
