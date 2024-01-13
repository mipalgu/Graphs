import Collections

/// Provides a means of defining a graph which can be stored in memory.
public struct InMemoryGraph<Node: NodeProtocol, Connection: ConnectionProtocol>: GraphProtocol
where Connection.Node == Node {

    /// The underlying collection containing all nodes with lookup by id
    /// functionality.
    ///
    /// This is essentially a hash table that is ordered.
    private var nodesLookup: OrderedDictionary<Node.ID, Node>

    /// All nodes that exist within this graph.
    public var nodes: OrderedDictionary<Node.ID, Node>.Values {
        nodesLookup.values
    }

    /// All connections that exist within this graph.
    public let connections: [Connection]

    /// Creates a new graph.
    ///
    /// - Parameters:
    ///   - nodes: The nodes that exist within the graph.
    ///   - connections: The connections that exist within the graph.
    public init(nodes: OrderedDictionary<Node.ID, Node>, connections: [Connection]) {
        self.nodesLookup = nodes
        self.connections = connections
    }

    /// Creates a new graph.
    ///
    /// - Parameters:
    ///   - nodes: The nodes that exist within the graph.
    ///   - connections: The connections that exist within the graph.
    public init(nodes: [Node.ID: Node], connections: [Connection]) {
        self.init(nodes: OrderedDictionary(uncheckedUniqueKeysWithValues: nodes), connections: connections)
    }

    /// Fetch a single node within this graph utilising the node id to identify
    /// it.
    public func node(_ id: Node.ID) -> Node? {
        nodesLookup[id]
    }

    /// Fetch all nodes that appear after the given node in the `nodes`
    /// collection.
    ///
    /// If the node does not exist in the graph, then `nil` is returned.
    ///
    /// - Parameter node: The id of the node to fetch the nodes after.
    ///
    /// - Returns: A collection of nodes that appear after the given node.
    public func nodes(after node: Node.ID) -> OrderedDictionary<Node.ID, Node>.Values.SubSequence? {
        guard let startingIndex = nodesLookup.index(forKey: node) else {
            return nil
        }
        let nodes = nodes
        return nodes[startingIndex.advanced(by: 1)..<nodes.endIndex]
    }

    /// Replace a node in the graph with a new node.
    ///
    /// This should place the new node within the same position as the node
    /// that is being replaced.
    ///
    /// - Parameter id: The id of the node to replace.
    ///
    /// - Parameter node: The new node to replace the old node.
    public mutating func replace(node id: Node.ID, with node: Node) {
        guard let index = nodesLookup.index(forKey: id) else {
            return
        }
        nodesLookup.values[index] = node
    }

}
