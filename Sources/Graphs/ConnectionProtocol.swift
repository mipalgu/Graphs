public protocol ConnectionProtocol: AnyObject {

    associatedtype Node: NodeProtocol

    var lhs: Node.ID { get }

    var rhs: Node.ID { get }

    var distance: Double { get }

}
