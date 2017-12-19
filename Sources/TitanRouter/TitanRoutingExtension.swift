import TitanCore

extension Titan {
    /// Core routing handler for Titan Routing.
    /// Passing `nil` for the method results in matching all methods for a given path
    /// Path matching is defined in `matchRoute` method, documented in `docs/Routes.md`
    public func route(method: String? = nil, path: String, handler: @escaping Function) {
        let routeFunction: Function = { (req, res) in
            if let m = method, m.uppercased() != req.method.uppercased() {
                return (req, res)
            }
            guard matchRoute(path: req.path.prefixUpToQuery(), route: path) else {
                return (req, res)
            }
            return handler(req, res)
        }
        addFunction(routeFunction)
    }

    /// Synonym for `route`
    public func addFunction(path: String, handler: @escaping Function) {
        route(path: path, handler: handler)
    }

    /// Synonym for `route`
    public func allMethods(path: String, handler: @escaping Function) {
        route(path: path, handler: handler)
    }

}

/// Match a given path with a route. Segments containing an asterisk are treated as wild.
/// Assuming querystring has already been stripped, including the question mark
private func matchRoute(path: String, route: String) -> Bool {
    guard route != "*" else { return true } // If it's a wildcard, bail out – I hope the branch predictor's okay with this!
    guard route.wildcards != 0 else {
        return path == route // If there are no wildcards, this is easy
    }

    // WILDCARD LOGIC

    let splitPath = path.splitOnSlashes() // /foo/bar/baz -> [foo, bar, baz]
    let splitRoute = route.splitOnSlashes() // /foo/*/baz -> [foo, *, baz]

    guard splitRoute.count == splitPath.count else { // if the number of route segments != path segments, then it can't be a match
        return false
    }
    let zipped = zip(splitPath, splitRoute) // produce [(foo, foo), (bar, *), (baz, baz)]
    for (pathSegment, routeSegment) in zipped {
        // If the route segment does not equal the path segment, and the route segment is not a wildcard, then it does not match
        if (routeSegment != pathSegment) && (routeSegment != "*") {
            return false
        } else {
            continue
        }
    }
    return true
}

extension String {
    /// Separate a string into an array of strings, separated by "/" characters
    func splitOnSlashes() -> [String] {
        return self.split(separator: "/").map { String($0) }
    }

    /// Return the number of "*" characters in `Self`
    var wildcards: Int {
        return self.reduce(0) { (count, char) in
            if char == "*" {
                return count + 1
            } else {
                return count
            }
        }
    }

    /// Return `Self` without the query string.
    func prefixUpToQuery() -> String {
        return self.index(of: "?")
            .map { self.prefix(upTo: $0) }
            .map(String.init) ?? self
    }
}
