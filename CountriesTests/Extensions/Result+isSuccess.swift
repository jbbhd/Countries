import UIKit
@testable import Countries

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
