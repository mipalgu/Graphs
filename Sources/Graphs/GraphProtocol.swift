/// A protocol that defines the operations available for graphs containing nodes
/// and connections.
public protocol GraphProtocol {

    /// Defines that type of nodes contained within this graph.
    associatedtype Node: NodeProtocol

    /// Defines that type of connections contained within this graph.
    associatedtype Connection: ConnectionProtocol where Connection.Node == Node

    /// Defines a collection that contains all nodes within this graph.
    ///
    /// This associatedtype allows conforming types to provide custom
    /// collections for fetching nodes within the graph. This is important for
    /// large graphs as it allows the graph algorithms to be written in a
    /// consistent manner, but also allows fetching the nodes from external
    /// data stores.
    associatedtype NodeCollection: Collection where NodeCollection.Iterator.Element == Node

    /// Defines a collection that contains all connections within this graph.
    ///
    /// This associatedtype allows conforming types to provide custom
    /// collections for fetching connections within the graph. This is
    /// important for large graphs as it allows the graph algorithms to be
    /// written in a consistent manner, but also allows fetching the
    /// connections from external data stores.
    associatedtype ConnectionCollection: Collection where ConnectionCollection.Iterator.Element == Connection

    /// All connections that exist within this graph.
    var connections: ConnectionCollection { get }

    /// All nodes that exist within this graph.
    var nodes: NodeCollection { get }

    /// Fetch a single node within this graph utilises its id to identify it.
    func node(_: Node.ID) -> Node?

    /// Fetch all nodes that appear after the given node in the `nodes`
    /// collection.
    ///
    /// If the node does not exist in the graph, then `nil` is returned.
    ///
    /// - Parameter node: The id of the node to fetch the nodes after.
    ///
    /// - Returns: A collection of nodes that appear after the given node.
    func nodes(after node: Node.ID) -> NodeCollection.SubSequence?

    /// Replace a node in the graph with a new node.
    ///
    /// This should place the new node within the same position as the node
    /// that is being replaced.
    ///
    /// - Parameter id: The id of the node to replace.
    ///
    /// - Parameter node: The new node to replace the old node.
    mutating func replace(node id: Node.ID, with node: Node)

}

/// Provides graph layout algorithm functionality.
public extension GraphProtocol {

    /// Perform a single simulation where all forces are applied to all nodes
    /// within the graph a single time.
    ///
    /// - Parameter gravityConstant: The constant force that moves the nodes
    /// towards the center of the canvas.
    ///
    /// - Parameter forceConstant: All other forces (including attraction and
    /// repulsion forces) are multiplied by this constant.
    mutating func simulate(gravityConstant: Point2D = -1.1, forceConstant: Point2D = 1000) {
        for var node in nodes {
            node.force = node.point * gravityConstant
            replace(node: node.id, with: node)
        }
        for var node in nodes {
            let point = node.point
            guard let otherNodes = nodes(after: node.id) else {
                continue
            }
            for var other in otherNodes where other.id != node.id {
                let diff = other.point - point
                let mag = diff.magnitude
                let relativeForce = mag == 0 ? forceConstant : (diff / Point2D(mag * mag)) * forceConstant
                node.force += relativeForce * -1
                other.force += relativeForce
                replace(node: other.id, with: other)
            }
            replace(node: node.id, with: node)
        }
        for connection in connections {
            guard var lhs = self.node(connection.lhs), var rhs = self.node(connection.rhs) else {
                continue
            }
            let distance = lhs.point - rhs.point
            let diff = distance.magnitude - connection.distance
            if abs(diff) < 0.1 {
                continue
            }
            lhs.force -= distance
            rhs.force += distance
            replace(node: lhs.id, with: lhs)
            replace(node: rhs.id, with: rhs)
        }
        for var node in nodes {
            node.point += node.force / Point2D(node.mass)
            replace(node: node.id, with: node)
        }
    }

    /// Perform a number of simulations where all forces are applied to all
    /// nodes within the graph a number of times.
    ///
    /// - Parameter times: The number of times to perform the simulation.
    ///
    /// - Parameter gravityConstant: The constant force that moves the nodes
    /// towards the center of the canvas.
    ///
    /// - Parameter forceConstant: All other forces (including attraction and
    /// repulsion forces) are multiplied by this constant.
    mutating func layout(times: Int = 1, gravityConstant: Point2D = -1.1, forceConstant: Point2D = 1000) {
        for _ in 0..<times {
            simulate(gravityConstant: gravityConstant, forceConstant: forceConstant)
        }
    }

}
