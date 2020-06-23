import UIKit

struct TMCountry: Codable {
    
    let name: String
    let flagURL: URL
    let capital: String
    let callingCodes: [String]
    let region: String
    let subRegion: String?
    let timeZones: [TimeZone]?
    let currencies: [TMCurrency]
    let languages: [TMLanguage]
    
    enum CodingKeys: String, CodingKey {
        case name
        case flagURL = "flag"
        case capital
        case callingCodes
        case region
        case subRegion
        case timeZones
        case currencies
        case languages
    }
}
