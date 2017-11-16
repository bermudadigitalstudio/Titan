import Foundation

/// Little known fact: HTTP headers need not be unique!
public typealias Header = (name: String, value: String)

public typealias Function = (RequestType, ResponseType) -> (RequestType, ResponseType)

public final class Titan {

    public init() {}

    private var functionStack = [Function]()

    /// add a function to Titan’s request / response processing flow
    public func addFunction(_ function: @escaping Function) {
        functionStack.append(function)
    }

    /// Titan handler which should be given to a server
    public func app(request: RequestType) -> ResponseType {
        typealias Result = (RequestType, ResponseType)

        let initialReq = request
        let initialRes = Response(code: -1, body: Data(), headers: [])
        let initial: Result = (initialReq, initialRes)
        let res = functionStack.reduce(initial) { (res, next) -> Result in
            return next(res.0, res.1)
        }
        return res.1
    }
}
