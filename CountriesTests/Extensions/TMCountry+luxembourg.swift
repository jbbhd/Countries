import UIKit
@testable import Countries

extension TMCountry {

    static let luxembourg = TMCountry(
        name: "Luxembourg",
        flagURL: URL(string: "https://restcountries.eu/data/lux.svg"),
        capital: "Luxembourg City",
        callingCodes: ["352"],
        region: "Europe",
        subregion: "Western Europe",
        timeZones: ["UTC+01:00"],
        currencies: [TMCurrency(code: "EUR", name: "Euro", symbol: "€")],
        languages: [
            TMLanguage(codeISO639_1: "fr", codeISO639_2: "fra", name: "French",        nativeName: "français"),
            TMLanguage(codeISO639_1: "de", codeISO639_2: "deu", name: "German",        nativeName: "Deutsch"),
            TMLanguage(codeISO639_1: "lb", codeISO639_2: "ltz", name: "Luxembourgish", nativeName: "Lëtzebuergesch"),
    ])
}
