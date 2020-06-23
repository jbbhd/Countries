import UIKit

extension Result {
    
    func isSuccess() -> Bool {
        switch self {
        case .failure:
            return false
        case .success:
            return true
        }
    }
}
