import Foundation

/// Little known fact: HTTP headers need not be unique!
public typealias Header = (name: String, value: String)

public typealias Function = (RequestType, ResponseType) -> (RequestType, ResponseType)

public final class Titan {

    public init() {}

    // A chain of Functions that are executed in order. The output of one is the input of the next; the final output is sent to the client.
    private var functionStack = [Function]()

    /// add a function to Titan’s request / response processing flow
    public func addFunction(_ function: @escaping Function) {
        functionStack.append(function)
    }

    /// Titan handler which should be given to a server
    public func app(request: RequestType, response: ResponseType) -> (RequestType, ResponseType) {
        typealias Result = (RequestType, ResponseType)

        let initial: Result = (request, response)
        // Apply the function one at a time to the request and the response, returning the result to the next function.
        return functionStack.reduce(initial) { (res, next) -> Result in
            return next(res.0, res.1)
        }
    }
    // Older versions of Titan provided no interface to the initial response object or the final request object. 
    // This deficiency has been remedied by the new version of 'app', above. 
    @available(*, unavailable, renamed: "app(request:response:)")
    public func app(request: RequestType) -> ResponseType {
        fatalError()
    }
}
