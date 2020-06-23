import UIKit

protocol TMCountriesSearcher: class {
    
    func countriesWithName(_ countryName: String, completion: @escaping (Result<[TMCountry], TMError>) -> Void)
}
