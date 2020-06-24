import UIKit

protocol TMCountriesSearching: class {
    
    func countriesWithName(_ countryName: String, completion: @escaping (Result<[TMCountry], TMError>) -> Void)
}
