import UIKit

private extension String {
    
    func noneTextIfEmpty() -> String {
        self == "" ? .noneText : self
    }
}

private extension Optional where Wrapped == String {
    
    func noneTextIfNilOrEmpty() -> String {
        self == nil || self! == "" ? .noneText : self!
    }
}

class TMCountryViewModel {
    
    private let country: TMCountry
    
    private (set) var flagURL: URL?
    
    private (set) var countryName: String = ""
    
    private (set) var capitalTitleText: String = ""
    
    private (set) var callingCodeTitleText: String = ""
    
    private (set) var regionTitleText: String = ""
    
    private (set) var subregionTitleText: String = ""
    
    private (set) var timeZonesTitleText: String = ""
    
    private (set) var currenciesTitleText: String = ""
    
    private (set) var languagesTitleText: String = ""
    
    private (set) var capitalText: String = ""
    
    private (set) var callingCodeText: String = ""
    
    private (set) var regionText: String = ""
    
    private (set) var subregionText: String = ""
    
    private (set) var timeZonesText: String = ""
    
    private (set) var currenciesText: String = ""
    
    private (set) var languagesText: String = ""
    
    init(country: TMCountry) {
        self.country = country

        self.flagURL = country.flagURL
        
        self.capitalTitleText        = createCapitalTitleText()
        self.callingCodeTitleText    = createCallingCodeTitleText()
        self.regionTitleText         = createRegionTitleText()
        self.subregionTitleText      = createSubregionTitleText()
        self.timeZonesTitleText      = createTimeZonesTitleText()
        self.currenciesTitleText     = createCurrenciesTitleText()
        self.languagesTitleText      = createLangugesTitleText()
        
        self.countryName        = createCountryName()
        self.capitalText        = createCapitalText()
        self.callingCodeText    = createCallingCodeText()
        self.regionText         = createRegionText()
        self.subregionText      = createSubregionText()
        self.timeZonesText      = createTimeZonesText()
        self.currenciesText     = createCurrenciesText()
        self.languagesText      = createLanguagesText()
    }
    
    private func createCapitalTitleText() -> String {
        return .capitalTitle + ":"
    }
    
    private func createCallingCodeTitleText() -> String {
        return .callingCodeTitle + ":"
    }
    
    private func createRegionTitleText() -> String {
        return .regionTitle + ":"
    }
       
    private func createSubregionTitleText() -> String {
        return .subregionTitle + ":"
    }
       
    private func createTimeZonesTitleText() -> String {
        return .timeZonesTitle + ":"
    }
       
    private func createCurrenciesTitleText() -> String {
        return .currenciesTitle + ":"
    }
    
    private func createLangugesTitleText() -> String {
        return .languagesTitle + ":"
    }
    
    private func createCountryName() -> String {
        return country.name.noneTextIfEmpty()
    }
    
    private func createCapitalText() -> String {
        return country.capital.noneTextIfEmpty()
    }
    
    private func createCallingCodeText() -> String {
        return country.callingCodes.count > 0
            ? country.callingCodes.joined(separator: .commaSeparatorText)
            : "None"
    }
    
    private func createRegionText() -> String {
        return country.region.noneTextIfEmpty()
    }
    
    private func createSubregionText() -> String {
        return country.subregion.noneTextIfNilOrEmpty()
    }
    
    private func createTimeZonesText() -> String {
        return country.timeZones != nil && country.timeZones!.count > 0
            ? country.timeZones!.map { $0 }.joined(separator: .commaSeparatorText)
            : .noneText
    }
    
    private func createCurrenciesText() -> String {
        return country.currencies != nil && country.currencies!.count > 0
            ? country.currencies!.map { $0.displayString }.joined(separator: .commaSeparatorText)
            : .noneText
    }
    
    private func createLanguagesText() -> String {
        return country.languages.count > 0
            ? country.languages.map { $0.displayString }.joined(separator: .commaSeparatorText)
            : .noneText
    }
}

extension TMCountryViewModel: TMCountryViewModeling {
    
}
