import UIKit

struct TMCurrency: Codable {
    
    let code: String?
    let name: String?
    let symbol: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case symbol
    }
    
    var displayString: String {
        if let name = self.name, let symbol = self.symbol {
            return "\(name) (\(symbol))"
        }
        return name ?? symbol ?? code ?? ""
    }
}

extension TMCurrency: Equatable {
    
}
