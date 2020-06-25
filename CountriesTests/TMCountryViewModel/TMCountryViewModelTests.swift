import XCTest
@testable import Countries

class TMCountryViewModelTests: XCTestCase {

    var countryName: String!
    var flagURL: URL?
    var capital: String!
    var callingCodes: [String]!
    var region: String!
    var subregion: String?
    var timeZones: [String]!
    var currencies: [TMCurrency]!
    var languages: [TMLanguage] = []
    
    let emptyCountryName = ""
    let nonEmptyCountryName = "Luxembourg"
    
    let emptyFlagURL: URL? = nil
    let nonEmptyFlagURL: URL? = URL(string: "https://restcountries.eu/data/lux.svg")
    
    let emptyCapital = ""
    let nonEmptyCapital = "Luxembourg City"

    let emptyRegion = ""
    let nonEmptyRegion = "Europe"
    
    let emptySubregion: String? = ""
    let nonEmptySubregion: String? = "Western Europe"
    
    let emptyCallingCodes: [String]? = []
    let singleCallingCode: [String]? = ["CallingCode1"]
    let multipleCallingCodes: [String]? = ["CallingCode1", "CallingCode2"]
    let multipleEmptyCallingCodes: [String]? = ["", ""]
    
    let emptyTimeZones: [String]? = []
    let singleTimeZone: [String]? = ["TimeZone1"]
    let multipleTimeZones: [String]? = ["TimeZone1", "TimeZone2"]
    let multipleEmptyTimeZones: [String]? = ["", ""]
    
    let emptyCurrencies: [TMCurrency]? = []
    let singleCurrency: [TMCurrency]? = [TMCurrency(code: "EUR", name: "Euro", symbol: "€")]
    let multipleCurrencies: [TMCurrency]? = [
        TMCurrency(code: "EUR", name: "Euro", symbol: "€"),
        TMCurrency(code: "USD", name: "Dollar", symbol: "$")
    ]
    let multipleEmptyCurrencies: [TMCurrency]? = [
        TMCurrency(code: nil, name: nil, symbol: nil),
        TMCurrency(code: nil, name: nil, symbol: nil)
    ]
    
    let emptyLanguages: [TMLanguage] = []
    let singleLanguage = [TMLanguage(codeISO639_1: "fr", codeISO639_2: "fra", name: "French", nativeName: "français")]
    let multipleLanguages = [
        TMLanguage(codeISO639_1: "fr", codeISO639_2: "fra", name: "French",        nativeName: "français"),
        TMLanguage(codeISO639_1: "de", codeISO639_2: "deu", name: "German",        nativeName: "Deutsch"),
    ]
    
    var country: TMCountry!
    var viewModel: TMCountryViewModel!

    override func setUpWithError() throws {
        countryName = nonEmptyCountryName
        flagURL = nonEmptyFlagURL
        capital = nonEmptyCapital
        callingCodes = singleCallingCode
        region = nonEmptyRegion
        subregion = nonEmptySubregion
        timeZones = singleTimeZone
        currencies = singleCurrency
        languages = singleLanguage
        setupViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
        
    func setupViewModel() {
        country = TMCountry(
            name: countryName,
            flagURL: flagURL,
            capital: capital,
            callingCodes: callingCodes,
            region: region,
            subregion: subregion,
            timeZones: timeZones,
            currencies: currencies,
            languages: languages)
        viewModel = TMCountryViewModel(country: country)
    }
    
    func testThatTitleTextValuesEndWithAColon() {
        XCTAssertEqual(viewModel.capitalTitleText.last!, ":")
        XCTAssertEqual(viewModel.callingCodeTitleText.last!, ":")
        XCTAssertEqual(viewModel.regionTitleText.last!, ":")
        XCTAssertEqual(viewModel.subregionTitleText.last!, ":")
        XCTAssertEqual(viewModel.timeZonesTitleText.last!, ":")
        XCTAssertEqual(viewModel.currenciesTitleText.last!, ":")
        XCTAssertEqual(viewModel.languagesTitleText.last!, ":")
    }
    
    // MARK: Flag
    
    func testThatFlagURLIsCorrectForNilAndNonNilFlagURL() {
        flagURL = emptyFlagURL
        setupViewModel()
        XCTAssertEqual(viewModel.flagURL, emptyFlagURL)
        
        flagURL = nonEmptyFlagURL
        setupViewModel()
        XCTAssertEqual(viewModel.flagURL, nonEmptyFlagURL)
    }
    
    // MARK: Strings
    
    func testThatCountryTextIsCorrectForEmptyAndNonEmptyCountryNames() {
        countryName = emptyCountryName
        setupViewModel()
        XCTAssertEqual(viewModel.countryName, "None")
        
        countryName = nonEmptyCountryName
        setupViewModel()
        XCTAssertEqual(viewModel.countryName, nonEmptyCountryName)
    }

    func testThatCountryTextIsCorrectForEmptyAndNonEmptyCapitals() {
        capital = emptyCapital
        setupViewModel()
        XCTAssertEqual(viewModel.capitalText, "None")
        
        capital = nonEmptyCapital
        setupViewModel()
        XCTAssertEqual(viewModel.capitalText, nonEmptyCapital)
    }
    
    func testThatCountryTextIsCorrectForEmptyAndNonEmptyRegions() {
        region = emptyRegion
        setupViewModel()
        XCTAssertEqual(viewModel.regionText, "None")
        
        region = nonEmptyRegion
        setupViewModel()
        XCTAssertEqual(viewModel.regionText, nonEmptyRegion)
    }
    
    // MARK: Optional Strings
    
    func testThatSubregionTextIsCorrectForNilEmptyAndNonEmptySubregion() {
        subregion = emptySubregion
        setupViewModel()
        XCTAssertEqual(viewModel.subregionText, "None")
        
        subregion = nonEmptySubregion
        setupViewModel()
        XCTAssertEqual(viewModel.subregionText, nonEmptySubregion)
    }
    
    // MARK: Arrays
    
    func testThatCallingCodeTextIsCorrectForEmptySingleAndMultipleCallingCodes() {
        callingCodes = emptyCallingCodes
        setupViewModel()
        XCTAssertEqual(viewModel.callingCodeText, "None")
        
        callingCodes = singleCallingCode
        setupViewModel()
        XCTAssertEqual(viewModel.callingCodeText, callingCodes[0])
        
        callingCodes = multipleCallingCodes
        setupViewModel()
        XCTAssertEqual(viewModel.callingCodeText, callingCodes.joined(separator: ", "))
        
        callingCodes = multipleEmptyCallingCodes
        setupViewModel()
        XCTAssertEqual(viewModel.callingCodeText, "None")
    }
    
    func testThatCallingCodeTextIsCorrectForEmptySingleAndMultipleLanguages() {
        languages = emptyLanguages
        setupViewModel()
        XCTAssertEqual(viewModel.languagesText, "None")
        
        languages = singleLanguage
        setupViewModel()
        XCTAssertEqual(viewModel.languagesText, languages[0].displayString)
        
        languages = multipleLanguages
        setupViewModel()
        XCTAssertEqual(viewModel.languagesText, languages.map { $0.displayString }.joined(separator: ", "))
    }
        
    func testThatCallingCodeTextIsCorrectForNilEmptySingleAndMultipleTimeZones() {
        timeZones = emptyTimeZones
        setupViewModel()
        XCTAssertEqual(viewModel.timeZonesText, "None")
        
        timeZones = singleTimeZone
        setupViewModel()
        XCTAssertEqual(viewModel.timeZonesText, timeZones?[0])
        
        timeZones = multipleTimeZones
        setupViewModel()
        XCTAssertEqual(viewModel.timeZonesText, timeZones?.joined(separator: ", "))
        
        timeZones = multipleEmptyTimeZones
        setupViewModel()
        XCTAssertEqual(viewModel.timeZonesText, "None")
    }
    
    func testThatCallingCodeTextIsCorrectForNilEmptySingleAndMultipleCurrencies() {
        currencies = emptyCurrencies
        setupViewModel()
        XCTAssertEqual(viewModel.currenciesText, "None")
        
        currencies = singleCurrency
        setupViewModel()
        XCTAssertEqual(viewModel.currenciesText, currencies?[0].displayString)
        
        currencies = multipleCurrencies
        setupViewModel()
        XCTAssertEqual(viewModel.currenciesText, currencies?.map { $0.displayString }.joined(separator: ", "))
        
        currencies = multipleEmptyCurrencies
        setupViewModel()
        XCTAssertEqual(viewModel.currenciesText, "None")
    }
}
