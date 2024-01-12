public final class Node: NodeProtocol {
    
    public let mass: Double

    public var force: Point2D

    public var x: Int

    public var y: Int

    public init(mass: Double, force: Point2D, x: Int = 0, y: Int = 0) {
        self.mass = mass
        self.force = force
        self.x = x
        self.y = y
    }

}
