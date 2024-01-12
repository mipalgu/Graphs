public protocol ConnectionProtocol {

    associatedtype Node: NodeProtocol

    var lhs: Node.ID { get }

    var rhs: Node.ID { get }

    var distance: Double { get }

}
