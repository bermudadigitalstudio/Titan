import Foundation
import TitanCore

/// Allow this app to be accessed with total violation of Same Origin Policy.
/// This adds the `AllowAllOrigins` and `RespondToPreflightAllowingAllMethods` functions.
public func addInsecureCORSSupport(_ titan: Titan) {
    titan.addFunction(respondToPreflightAllowingAllMethods)
    titan.addFunction(allowAllOrigins)
}

/// A header that allows all origins. You probably want to use the `AllowAllOrigins` Function instead
public let allowAllOriginsHeader: Header = ("access-control-allow-origin", "*")

/// If one isn't present, insert a wildcard CORS allowed origin header
public let allowAllOrigins: Function = { req, res in
    var respHeaders = res.headers
    guard (respHeaders.contains { header in
        return header.name.lowercased() == "access-control-allow-origin"
        } != true) else {
            return (req, res)
    }
    respHeaders.append(allowAllOriginsHeader)
    return (req, Response(code: res.code, body: res.body, headers: respHeaders))
}

/// Respond to a CORS preflight request, allowing all methods requested in the preflight.
public let respondToPreflightAllowingAllMethods: Function = { req, res in
    guard req.method.uppercased() == "OPTIONS" else {
        return (req, res)
    }
    guard let requestedMethods = (req.headers.first(where: { (name, _) -> Bool in
        return name.lowercased() == "access-control-request-method"
    }).map { (header: Header) -> String in
        return header.value
    }) else {
        return (req, res)
    }
    var headers: [Header] = []
    headers.append(("access-control-allow-methods", requestedMethods))
    if let requestedHeaders = (req.headers.first(where: { (name, _) -> Bool in
        return name.lowercased() == "access-control-request-headers"
    }).map { (header: Header) -> String in
        return header.value
    }) {
        headers.append(("access-control-allow-headers", requestedHeaders))
    } else {
        headers.append(("access-control-allow-headers", "*"))
    }
    return (req, Response(code: 200, body: Data(), headers: headers))
}
