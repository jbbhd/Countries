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

extension TMCountry: Equatable {
    static func == (lhs: TMCountry, rhs: TMCountry) -> Bool {
        return lhs.name         == rhs.name
            && lhs.flagURL      == rhs.flagURL
            && lhs.capital      == rhs.capital
            && lhs.callingCodes == rhs.callingCodes
            && lhs.region       == rhs.region
            && lhs.subregion    == rhs.subregion
            && lhs.timeZones    == rhs.timeZones
            && lhs.currencies   == rhs.currencies
            && lhs.languages    == rhs.languages
    }
    
    
}
