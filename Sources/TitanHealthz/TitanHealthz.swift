import Foundation
import TitanCore

/// A basic healthcheck route that returns 200 and diagnostic info
public let healthz: Function = healthzWithCheck(check: { return nil })

// Workaround for https://bugs.swift.org/browse/SR-6391
let cachedHostname: String = {
    return ProcessInfo.processInfo.hostName
}()

/// Creates a healthcheck route that executes the supplied closure.
/// If a string is returned, the string is returned as part of the diagnostic info in the
/// healthcheck 200 response.
/// If an error is thrown, the error is coerced to a string and printed inside a 500 response.
public func healthzWithCheck(check: @escaping () throws -> String?) -> Function {
    return { req, res in

        guard req.path.lowercased() == "/healthz",
            req.method.lowercased() == "get" else {
                return (req, res)
        }

        do {
            let result = try check() ?? "Ok"
            let ok = try Response(code: 200,
                                  body: "Host: \(cachedHostname)\nTime: \(Date())\n\nStatus: \(result)",
                headers: HTTPHeaders())
            return (req, ok)
        } catch {
            let body = "Host: \(cachedHostname)\nTime: \(Date())\n\nStatus: \(error)".data(using: .utf8) ?? Data()
            let notOk = Response(code: 500, body: body, headers: HTTPHeaders())
            return (req, notOk)
        }
    }
}
