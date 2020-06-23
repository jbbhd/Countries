import UIKit

protocol TMCountriesViewModelImplDelegate: class {
    
    func countriesViewModel(_ viewModel: TMCountriesViewModelImpl, didSelectCountry country: TMCountry)
}
