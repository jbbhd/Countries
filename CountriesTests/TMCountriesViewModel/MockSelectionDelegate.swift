import XCTest
@testable import Countries

class MockSelectionDelegate: TMCountriesViewModelDelegate {
    
    var completion: ((TMCountry) -> Void)?
    
    func countriesViewModel(_ viewModel: TMCountriesViewModel, didSelectCountry country: TMCountry) {
        completion?(country)
    }
}
