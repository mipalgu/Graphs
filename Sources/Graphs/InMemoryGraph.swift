public struct InMemoryGraph<Node: NodeProtocol, Connection: ConnectionProtocol>: GraphProtocol
where Connection.Node == Node {

    public private(set) var nodesLookup: [Node.ID: Node]

    public var nodes: Dictionary<Node.ID, Node>.Values {
        nodesLookup.values
    }

    public let connections: [Connection]

    public init(nodes: [Node.ID: Node], connections: [Connection]) {
        self.nodesLookup = nodes
        self.connections = connections
    }

    public func node(_ id: Node.ID) -> Node? {
        nodesLookup[id]
    }

    public func nodes(after node: Node.ID) -> Dictionary<Node.ID, Node>.Values.SubSequence? {
        guard let startingIndex = nodesLookup.index(forKey: node) else {
            return nil
        }
        let nodes = nodes
        return nodes[startingIndex..<nodes.endIndex]
    }

    public mutating func replace(node id: Node.ID, with node: Node) {
        guard nodesLookup[id] != nil else {
            return
        }
        nodesLookup[id] = node
    }

}
