import UIKit

class TMCountriesSearchCache {
    
    private let searcher: TMCountriesSearcher
    
    private var cache: [String: [TMCountry]] = [:]
        
    init(searcher: TMCountriesSearcher) {
        self.searcher = searcher
    }
}

extension TMCountriesSearchCache: TMCountriesSearcher {
    
    func countriesWithName(_ name: String, completion: @escaping (Result<[TMCountry], TMError>) -> Void) {
        if let results = cache[name] {
            return completion(.success(results))
        }
        searcher.countriesWithName(name) { (result) in
            if case .success(let countries) = result {
                self.cache[name] = countries
            }
            completion(result)
        }
    }
}
