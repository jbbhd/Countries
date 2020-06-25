import UIKit

extension Optional where Wrapped == String {
    
    func nilIfEmpty() -> String? {
        return self == nil || self! == "" ? nil : self!
    }
}
