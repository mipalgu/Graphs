public struct InMemoryGraph<Node: NodeProtocol, Connection: ConnectionProtocol> where Connection.Node == Node {

    public let nodes: [Node.ID: Node]

    public let connections: [Connection]

    public init(nodes: [Node.ID: Node], connections: [Connection]) {
        self.nodes = nodes
        self.connections = connections
    }

    public func node(_ id: Node.ID) -> Node? {
        nodes[id]
    }

    public func nodes(after node: Node.ID) -> Dictionary<Node.ID, Node>.SubSequence? {
        guard let startingIndex = nodes.index(forKey: node) else {
            return nil
        }
        return nodes[startingIndex..<nodes.endIndex]
    }

}
