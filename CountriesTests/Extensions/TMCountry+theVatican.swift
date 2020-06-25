import UIKit
@testable import Countries

extension TMCountry {

    static let theVatican = TMCountry(
        name: "Holy See",
        flagURL: URL(string: "https://restcountries.eu/data/vat.svg"),
        capital: "Rome",
        callingCodes: ["379"],
        region: "Europe",
        subregion: "Southern Europe",
        timeZones: ["UTC+01:00"],
        currencies: [TMCurrency(code: "EUR", name: "Euro", symbol: "€")],
        languages: [
            TMLanguage(codeISO639_1: "la", codeISO639_2: "lat", name: "Latin", nativeName: "latine"),
            TMLanguage(codeISO639_1: "it", codeISO639_2: "ita", name: "Italian", nativeName: "Italiano"),
            TMLanguage(codeISO639_1: "fr", codeISO639_2: "fra", name: "French", nativeName: "français"),
            TMLanguage(codeISO639_1: "de", codeISO639_2: "deu", name: "German", nativeName: "Deutsch"),
    ])
}
