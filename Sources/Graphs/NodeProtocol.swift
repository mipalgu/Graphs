public protocol NodeProtocol: AnyObject, Identifiable {

    var mass: Double { get }

    var force: Point2D { get set }

    var x: Int { get set }

    var y: Int { get set }

}

public extension NodeProtocol {

    var point: Point2D {
        get {
            Point2D(node: self)
        } set {
            self.x = Int(newValue.x.rounded(.toNearestOrAwayFromZero))
            self.y = Int(newValue.y.rounded(.toNearestOrAwayFromZero))
        }
    }

    func distance(to other: Self) -> Double {
        point.distance(to: other.point)
    }

}
