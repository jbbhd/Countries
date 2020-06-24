import UIKit

struct TMCountry: Decodable {
    
    let name: String
    let flagURL: URL?
    let capital: String
    let callingCodes: [String]
    let region: String
    let subregion: String?
    var timeZones: [String]?
    let currencies: [TMCurrency]?
    let languages: [TMLanguage]
    
    enum CodingKeys: String, CodingKey {
        case name
        case flagURL = "flag"
        case capital
        case callingCodes
        case region
        case subregion = "subregion"
        case timeZones = "timezones"
        case currencies
        case languages
    }
}
