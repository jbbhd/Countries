import UIKit
import Combine

class TMCountriesViewModelImpl {
    
    let numberOfCountries = CurrentValueSubject<Int, Never>(0)
    
    private var countries: [TMCountry] = []
    
    private let searcher: TMCountriesSearcher
    
    private weak var selectionDelegate: TMCountriesViewModelImplDelegate?
    
    private var searchID = arc4random()
    
    init(searcher: TMCountriesSearcher, selectionDelegate: TMCountriesViewModelImplDelegate?) {
        self.searcher = searcher
        self.selectionDelegate = selectionDelegate
    }
    
    func setSelectionDelegate(_ selectionDelegate: TMCountriesViewModelImplDelegate?) {
        self.selectionDelegate = selectionDelegate
    }
}

extension TMCountriesViewModelImpl: TMCountriesViewModel {
    
    func countryName(at index: Int) -> String {
        return countries[index].name
    }

    func countryFlagURL(at index: Int) -> URL? {
        return countries[index].flagURL
    }
    
    func didSelectCountry(at index: Int) {
        selectionDelegate?.countriesViewModel(self, didSelectCountry: countries[index])
    }
    
    func didChangeQuery(_ query: String) {
        let thisSearchID = arc4random()
        searchID = thisSearchID
        searcher.countriesWithName(query) { [weak self] (result) in
            guard let self = self else { return }
            guard thisSearchID == self.searchID else { return }
            switch result {
            case .failure(_):
                // FIXME: Handle error.
                break
            case .success(let countries):
                self.countries = countries
                self.numberOfCountries.send(countries.count)
            }
        }
    }
}
