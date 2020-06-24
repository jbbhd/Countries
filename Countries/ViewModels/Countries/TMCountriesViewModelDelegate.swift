import UIKit

protocol TMCountriesViewModelDelegate: class {
    
    func countriesViewModel(_ viewModel: TMCountriesViewModel, didSelectCountry country: TMCountry)
}
