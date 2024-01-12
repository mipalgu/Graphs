public struct Point2D: Hashable, Codable, Sendable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {

    public static func + (lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    public static func - (lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    public static func * (lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }

    public static func / (lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }

    public static func += (lhs: inout Point2D, rhs: Point2D) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }

    public static func -= (lhs: inout Point2D, rhs: Point2D) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }

    public static func *= (lhs: inout Point2D, rhs: Point2D) {
        lhs.x *= rhs.x
        lhs.y *= rhs.y
    }

    public static func /= (lhs: inout Point2D, rhs: Point2D) {
        lhs.x /= rhs.x
        lhs.y /= rhs.y
    }

    public static func + (lhs: Point2D, rhs: Double) -> Point2D {
        Point2D(x: lhs.x + rhs, y: lhs.y + rhs)
    }

    public static func - (lhs: Point2D, rhs: Double) -> Point2D {
        Point2D(x: lhs.x - rhs, y: lhs.y - rhs)
    }

    public static func * (lhs: Point2D, rhs: Double) -> Point2D {
        Point2D(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    public static func / (lhs: Point2D, rhs: Double) -> Point2D {
        Point2D(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    public static func += (lhs: inout Point2D, rhs: Double) {
        lhs.x += rhs
        lhs.y += rhs
    }

    public static func -= (lhs: inout Point2D, rhs: Double) {
        lhs.x -= rhs
        lhs.y -= rhs
    }

    public static func *= (lhs: inout Point2D, rhs: Double) {
        lhs.x *= rhs
        lhs.y *= rhs
    }

    public static func /= (lhs: inout Point2D, rhs: Double) {
        lhs.x /= rhs
        lhs.y /= rhs
    }

    public var x: Double

    public var y: Double

    public var magnitude: Double {
        (x * x + y * y).squareRoot()
    }

    public init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }

    public init(_ value: Double) {
        self.init(x: value, y: value)
    }

    public init<Node: NodeProtocol>(node: Node) {
        self.init(x: Double(node.x), y: Double(node.y))
    }

    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Double(value))
    }

    public init(floatLiteral value: FloatLiteralType) {
        self.init(Double(value))
    }

    public func distance(to other: Point2D) -> Double {
        (other - self).magnitude
    }

}
