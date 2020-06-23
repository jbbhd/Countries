import UIKit

enum TMError: LocalizedError {
    
    case standard
    case statusCode(_ statusCode: Int)
    case wrapped(_ error: Error)
    
    var localizedDescription: String {
        switch self {
        case .standard:
            return "An error occurred."
        case .statusCode(let statusCode):
            return "Status code: \(statusCode)"
        case .wrapped(let _):
            // FIXME: Do something with real error.
            return "An error occurred."
        }
    }
    
    var errorDescription: String? {
        return localizedDescription
    }
}
