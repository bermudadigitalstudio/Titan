import Foundation

public enum TitanError: Error {
    case dataConversion
}

extension TitanError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataConversion:
            return "failed converting body String to Data."
        }
    }
    public var failureReason: String? {
        switch self {
        case .dataConversion:
            return "String is not utf8 encoded."
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case .dataConversion:
            return "String must be utf8 encoded."
        }
    }
}
