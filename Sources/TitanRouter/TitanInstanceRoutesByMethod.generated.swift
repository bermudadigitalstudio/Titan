import TitanCore

// Core routing methods for Titan, matching HTTP methods
extension Titan {

    public func get(path: String, handler: @escaping Function) {
        route(method: "GET", path: path, handler: handler)
    }

    public func post(path: String, handler: @escaping Function) {
        route(method: "POST", path: path, handler: handler)
    }

    public func put(path: String, handler: @escaping Function) {
        route(method: "PUT", path: path, handler: handler)
    }

    public func patch(path: String, handler: @escaping Function) {
        route(method: "PATCH", path: path, handler: handler)
    }

    public func delete(path: String, handler: @escaping Function) {
        route(method: "DELETE", path: path, handler: handler)
    }

    public func options(path: String, handler: @escaping Function) {
        route(method: "OPTIONS", path: path, handler: handler)
    }

    public func head(path: String, handler: @escaping Function) {
        route(method: "HEAD", path: path, handler: handler)
    }

}
