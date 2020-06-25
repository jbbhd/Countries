import UIKit

struct TMCountry: Decodable {
    
    let name: String
    let flagURL: URL?
    let capital: String
    let callingCodes: [String]
    let region: String
    let subregion: String?
    var timeZones: [String]
    let currencies: [TMCurrency]
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name).trimmingCharacters(in: .whitespacesAndNewlines)
        flagURL = try values.decode(URL?.self, forKey: .flagURL)
        capital = try values.decode(String.self, forKey: .capital).trimmingCharacters(in: .whitespacesAndNewlines)
        region = try values.decode(String.self, forKey: .region).trimmingCharacters(in: .whitespacesAndNewlines)
        subregion = try values.decode(String?.self, forKey: .subregion)?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let rawCallingCodes = try values.decode([String].self, forKey: .callingCodes)
        callingCodes = rawCallingCodes.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter({ !$0.isEmpty })
        
        let rawTimeZones = try values.decode([String]?.self, forKey: .timeZones)
        timeZones = rawTimeZones?.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter({ !$0.isEmpty }) ?? []
        
        let rawCurrencies = try values.decode([[String: String?]]?.self, forKey: .currencies)
        currencies = rawCurrencies?.compactMap({ dictionary in
            let code = (dictionary[TMCurrency.CodingKeys.code.rawValue]?.nilIfEmpty() ?? "").trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty()
            let name = (dictionary[TMCurrency.CodingKeys.name.rawValue]?.nilIfEmpty() ?? "").trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty()
            let symbol = (dictionary[TMCurrency.CodingKeys.symbol.rawValue]?.nilIfEmpty() ?? "").trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty()
            guard code != nil || name != nil || symbol != nil else { return nil }
            return TMCurrency(code: code, name: name, symbol: symbol)
        }) ?? []

        let rawLanguages = try values.decode([[String: String?]]?.self, forKey: .languages)
        languages = rawLanguages?.compactMap({ dictionary in
            let code1 = (dictionary[TMLanguage.CodingKeys.codeISO639_1.rawValue]?.nilIfEmpty() ?? "").trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty()
            let code2 = (dictionary[TMLanguage.CodingKeys.codeISO639_2.rawValue]?.nilIfEmpty() ?? "").trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty()
            let name = (dictionary[TMLanguage.CodingKeys.name.rawValue]?.nilIfEmpty() ?? "").trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty()
            let nativeName = (dictionary[TMLanguage.CodingKeys.name.rawValue]?.nilIfEmpty() ?? "").trimmingCharacters(in: .whitespacesAndNewlines).nilIfEmpty()
            guard let nonNilName = name else { return nil }
            return TMLanguage(codeISO639_1: code1, codeISO639_2: code2, name: nonNilName, nativeName: nativeName)
        }) ?? []
    }
    
    init(name: String, flagURL: URL?, capital: String, callingCodes: [String], region: String, subregion: String?, timeZones: [String], currencies: [TMCurrency], languages: [TMLanguage]) {
        self.name = name
        self.flagURL = flagURL
        self.capital = capital
        self.callingCodes = callingCodes
        self.region = region
        self.subregion = subregion
        self.timeZones = timeZones
        self.currencies = currencies
        self.languages = languages
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
