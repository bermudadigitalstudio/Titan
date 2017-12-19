//
//  TitanHeader.swift
//

import Foundation

public typealias Header = (name: String, value: String)

/// Representation of the HTTP headers associated with a `RequestType` or `ResponseType`.
/// HTTPHeaders are subscritable using case-insensitive comparison.
///
/// Little known fact: HTTP headers need not be unique!
public struct HTTPHeaders {
    public private(set) var headers: [Header]

    public init() {
        self.headers = [Header]()
    }

    public init(headers: [Header]) {
        self.headers = headers
    }

    /// Get the first value associated with the `name` if any.
    public subscript(name: String) -> String? {
        get {
            return self.headers.first { $0.name.lowercased() == name.lowercased()}?.value
        }

        set {
            guard let newValue = newValue else {
                return
            }
            self.headers.append((name.lowercased(), newValue))
        }
    }

    /// Remove all the headers with the `name`.
    public mutating func removeHeaders(name: String) {
        self.headers = headers.filter({ (key, _) -> Bool in
            return key.lowercased() != name.lowercased()
        })
    }

}

extension HTTPHeaders: Sequence {
    public typealias Iteraror = DictionaryIterator<String, String>

    public func makeIterator() -> AnyIterator<Header> {
      var iterator = headers.makeIterator()

        return AnyIterator {
            return iterator.next()
        }
    }

}

extension HTTPHeaders: ExpressibleByDictionaryLiteral {

    public init(dictionaryLiteral elements: (String, String)...) {
        self.init()
        for (key, value) in elements {
            self.headers.append((key, value))
        }

    }
}

/// Joins two headers, overwriting the `key` and `value` in the `lhs` with `rhs`.
public func +(lhs: HTTPHeaders, rhs: HTTPHeaders) -> HTTPHeaders {
    var lhs = lhs

    for (key, value) in rhs {
        lhs[key] = value
    }

    return lhs
}
