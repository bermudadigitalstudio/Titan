import TitanCore

// Routing methods for Titan overloaded with no labels
extension Titan {

    public func get(_ path: String, _ handler: @escaping Function) {
        self.get(path: path, handler: handler)
    }

    public func post(_ path: String, _ handler: @escaping Function) {
        self.post(path: path, handler: handler)
    }

    public func put(_ path: String, _ handler: @escaping Function) {
        self.put(path: path, handler: handler)
    }

    public func patch(_ path: String, _ handler: @escaping Function) {
        self.patch(path: path, handler: handler)
    }

    public func delete(_ path: String, _ handler: @escaping Function) {
        self.delete(path: path, handler: handler)
    }

    public func options(_ path: String, _ handler: @escaping Function) {
        self.options(path: path, handler: handler)
    }

    public func head(_ path: String, _ handler: @escaping Function) {
        self.head(path: path, handler: handler)
    }

    public func get(_ path: String, _ handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        self.get(path: path, handler: handler)
    }

    public func get(_ path: String, _ handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.get(path: path, handler: handler)
    }

    public func get(_ path: String, _ handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.get(path: path, handler: handler)
    }

    public func get(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.get(path: path, handler: handler)
    }

    public func get(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.get(path: path, handler: handler)
    }

    public func post(_ path: String, _ handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        self.post(path: path, handler: handler)
    }

    public func post(_ path: String, _ handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.post(path: path, handler: handler)
    }

    public func post(_ path: String, _ handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.post(path: path, handler: handler)
    }

    public func post(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.post(path: path, handler: handler)
    }

    public func post(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.post(path: path, handler: handler)
    }

    public func put(_ path: String, _ handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        self.put(path: path, handler: handler)
    }

    public func put(_ path: String, _ handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.put(path: path, handler: handler)
    }

    public func put(_ path: String, _ handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.put(path: path, handler: handler)
    }

    public func put(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.put(path: path, handler: handler)
    }

    public func put(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.put(path: path, handler: handler)
    }

    public func patch(_ path: String, _ handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        self.patch(path: path, handler: handler)
    }

    public func patch(_ path: String, _ handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.patch(path: path, handler: handler)
    }

    public func patch(_ path: String, _ handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.patch(path: path, handler: handler)
    }

    public func patch(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.patch(path: path, handler: handler)
    }

    public func patch(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.patch(path: path, handler: handler)
    }

    public func delete(_ path: String, _ handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        self.delete(path: path, handler: handler)
    }

    public func delete(_ path: String, _ handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.delete(path: path, handler: handler)
    }

    public func delete(_ path: String, _ handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.delete(path: path, handler: handler)
    }

    public func delete(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.delete(path: path, handler: handler)
    }

    public func delete(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.delete(path: path, handler: handler)
    }

    public func options(_ path: String, _ handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        self.options(path: path, handler: handler)
    }

    public func options(_ path: String, _ handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.options(path: path, handler: handler)
    }

    public func options(_ path: String, _ handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.options(path: path, handler: handler)
    }

    public func options(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.options(path: path, handler: handler)
    }

    public func options(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.options(path: path, handler: handler)
    }

    public func head(_ path: String, _ handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        self.head(path: path, handler: handler)
    }

    public func head(_ path: String, _ handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.head(path: path, handler: handler)
    }

    public func head(_ path: String, _ handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.head(path: path, handler: handler)
    }

    public func head(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.head(path: path, handler: handler)
    }

    public func head(_ path: String, _ handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        self.head(path: path, handler: handler)
    }

    public func route(_ method: String?, _ path: String, _ handler: @escaping Function) {
        self.route(method: method, path: path, handler: handler)
    }

    public func addFunction(_ path: String, _ handler: @escaping Function) {
        self.addFunction(path: path, handler: handler)
    }

    public func allMethods(_ path: String, _ handler: @escaping Function) {
        self.allMethods(path: path, handler: handler)
    }

}
