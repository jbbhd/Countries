import XCTest
@testable import Countries

class MockCountryViewModel: TMCountryViewModeling {
    
    var flagURLCompletion: (() -> Void)?
    var countryNameCompletion: (() -> Void)?
    var capitalTitleTextCompletion: (() -> Void)?
    var callingCodeTitleTextCompletion: (() -> Void)?
    var regionTitleTextCompletion: (() -> Void)?
    var subregionTitleTextCompletion: (() -> Void)?
    var timeZonesTitleTextCompletion: (() -> Void)?
    var currenciesTitleTextCompletion: (() -> Void)?
    var languagesTitleTextCompletion: (() -> Void)?
    var capitalTextCompletion: (() -> Void)?
    var callingCodeTextCompletion: (() -> Void)?
    var regionTextCompletion: (() -> Void)?
    var subregionTextCompletion: (() -> Void)?
    var timeZonesTextCompletion: (() -> Void)?
    var currenciesTextCompletion: (() -> Void)?
    var languagesTextCompletion: (() -> Void)?
    
    var flagURL: URL? {
        flagURLCompletion?()
        return nil
    }
    
    var countryName: String {
        countryNameCompletion?()
        return ""
    }
    
    var capitalTitleText: String {
        capitalTitleTextCompletion?()
        return ""
    }
    
    var callingCodeTitleText: String {
        callingCodeTitleTextCompletion?()
        return ""
    }
    
    var regionTitleText: String {
        regionTitleTextCompletion?()
        return ""
    }
    
    var subregionTitleText: String {
        subregionTitleTextCompletion?()
        return ""
    }
    
    var timeZonesTitleText: String {
        timeZonesTitleTextCompletion?()
        return ""
    }
    
    var currenciesTitleText: String {
        currenciesTitleTextCompletion?()
        return ""
    }
    
    var languagesTitleText: String {
        languagesTitleTextCompletion?()
        return ""
    }
    
    var capitalText: String {
        capitalTextCompletion?()
        return ""
    }
    
    var callingCodeText: String {
        callingCodeTextCompletion?()
        return ""
    }
    
    var regionText: String {
        regionTextCompletion?()
        return ""
    }
    
    var subregionText: String {
        subregionTextCompletion?()
        return ""
    }
    
    var timeZonesText: String {
        timeZonesTextCompletion?()
        return ""
    }
    
    var currenciesText: String {
        currenciesTextCompletion?()
        return ""
    }
    
    var languagesText: String {
        languagesTextCompletion?()
        return ""
    }
}
