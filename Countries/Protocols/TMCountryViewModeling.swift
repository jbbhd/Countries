import UIKit

protocol TMCountryViewModeling: class {
    
    var flagURL: URL? { get }
    var countryName: String { get }
    
    var capitalTitleText: String { get }
    var callingCodeTitleText: String { get }
    var regionTitleText: String { get }
    var subregionTitleText: String { get }
    var timeZonesTitleText: String { get }
    var currenciesTitleText: String { get }
    var languagesTitleText: String { get }
    
    var capitalText: String { get }
    var callingCodeText: String { get }
    var regionText: String { get }
    var subregionText: String { get }
    var timeZonesText: String { get }
    var currenciesText: String { get }
    var languagesText: String { get }
}
