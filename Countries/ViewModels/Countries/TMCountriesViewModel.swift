import UIKit
import Combine

private extension TimeInterval {
    
    static let delayToAccountForTyping: TimeInterval = 0.1
}

class TMCountriesViewModel {
    
    let numberOfCountries = CurrentValueSubject<Int, Never>(0)
    
    private var countries: [TMCountry] = []
    
    private let searcher: TMCountriesSearching
    
    private weak var delegate: TMCountriesViewModelDelegate?
    
    private var searchID = arc4random()
        
    init(searcher: TMCountriesSearching, delegate: TMCountriesViewModelDelegate?) {
        self.searcher = searcher
        self.delegate = delegate
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
        delegate?.countriesViewModel(self, didSelectCountry: countries[index])
    }
    
    func didChangeQuery(_ query: String) {
        let thisSearchID = arc4random()
        searchID = thisSearchID
        DispatchQueue.main.asyncAfter(deadline: .now() + .delayToAccountForTyping) {
            guard self.searchID == thisSearchID else { return }
            if query == "" {
                self.setCountries([])
                return
            }
            self.searcher.countriesWithName(query) { (result) in
                guard self.searchID == thisSearchID else { return }
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
}
