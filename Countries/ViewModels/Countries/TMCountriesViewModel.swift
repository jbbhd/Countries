import UIKit
import Combine

class TMCountriesViewModel {
    
    let numberOfCountries = CurrentValueSubject<Int, Never>(0)
    
    private var countries: [TMCountry] = []
    
    private let searcher: TMCountriesSearching
    
    private weak var selectionDelegate: TMCountriesViewModelDelegate?
    
    private var searchID = arc4random()
    
    init(searcher: TMCountriesSearching, selectionDelegate: TMCountriesViewModelDelegate?) {
        self.searcher = searcher
        self.selectionDelegate = selectionDelegate
    }
    
    private func setCountries(_ countries: [TMCountry]) {
        self.countries = countries
        self.numberOfCountries.send(countries.count)
    }
}

extension TMCountriesViewModel: TMCountriesViewModeling {
    
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
        if query == "" {
            setCountries([])
            return
        }
        searcher.countriesWithName(query) { [weak self] (result) in
            guard let self = self else { return }
            guard thisSearchID == self.searchID else { return }
            switch result {
            case .failure(let error):
                // FIXME: Handle error.
                print(error)
            case .success(let countries):
                self.setCountries(countries)
            }
        }
    }
}
