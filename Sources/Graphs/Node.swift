public final class Node: NodeProtocol, CustomStringConvertible {

    public let mass: Double

    public var force: Point2D

    public var x: Int

    public var y: Int

    public var description: String {
        "Node(mass: \(mass), force: \(force), x: \(x), y: \(y))"
    }

    public init(mass: Double, force: Point2D = 0, x: Int = 0, y: Int = 0) {
        self.mass = mass
        self.force = force
        self.x = x
        self.y = y
    }

}
