import UIKit

extension String {
    
    func nilIfEmpty() -> String? {
        self == "" ? nil : self
    }
}
