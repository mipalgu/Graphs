public final class AnyNode<ID: Hashable>: NodeProtocol {

    private let _id: () -> ID

    private let _mass: () -> Double

    private let _force: () -> Point2D

    private let _setForce: (Point2D) -> Void

    private let _x: () -> Int

    private let _setX: (Int) -> Void

    private let _y: () -> Int

    private let _setY: (Int) -> Void

    public var id: ID {
        _id()
    }

    public var mass: Double {
        _mass()
    }

    public var force: Point2D {
        get {
            _force()
        } set {
            _setForce(newValue)
        }
    }

    public var x: Int {
        get {
            _x()
        } set {
            _setX(newValue)
        }
    }

    public var y: Int {
        get {
            _y()
        } set {
            _setY(newValue)
        }
    }

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
