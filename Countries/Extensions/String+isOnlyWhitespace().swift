import UIKit

extension String {
    
    func isOnlyWhitespace() -> Bool {
        return self.components(separatedBy: .whitespacesAndNewlines).joined().count == 0
    }
}
