import UIKit
import Combine

protocol TMCountriesViewModel: class {

    var numberOfCountries: CurrentValueSubject<Int, Never> { get }
    func countryName(at index: Int) -> String
    func countryFlagURL(at index: Int) -> URL?
    func didSelectCountry(at index: Int)
    func didChangeQuery(_ query: String)
}
