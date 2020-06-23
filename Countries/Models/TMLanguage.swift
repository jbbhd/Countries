import UIKit

struct TMLanguage: Codable {
    
    let codeISO639_1: String
    let codeISO639_2: String
    let name: String
    let nativeName: String
    
    enum CodingKeys: String, CodingKey {
        case codeISO639_1 = "iso639_1"
        case codeISO639_2 = "iso639_2"
        case name
        case nativeName
    }
}
