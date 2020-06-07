
import Foundation

enum FetchError : Error {
    case invalidData
    case parseError
    case customError(Error)
}

extension FetchError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidData:
            return NSLocalizedString("Invalid Data Received", comment: "")
        case .parseError:
            return NSLocalizedString("Error parsing api data", comment: "")
        case .customError(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        }
    }
}
