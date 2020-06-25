import XCTest
@testable import Countries

class MockSearcher: TMCountriesSearching {
    
    var result: Result<[TMCountry], TMError>?
    var completion: (() -> Void)?
    
    var queryResult1: [TMCountry]?
    var queryDelay1: TimeInterval?
    
    var queryResult2: [TMCountry]?
    var queryDelay2: TimeInterval?
    
    func countriesWithName(_ countryName: String, completion resultsCompletion: @escaping (Result<[TMCountry], TMError>) -> Void) {
        if let queryResult1 = self.queryResult1, let queryDelay1 = self.queryDelay1 {
            self.queryResult1 = nil
            self.queryDelay1 = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + queryDelay1) {
                self.completion?()
                resultsCompletion(.success(queryResult1))
            }
        } else if let queryResult2 = self.queryResult2, let queryDelay2 = self.queryDelay2 {
            self.queryResult2 = nil
            self.queryDelay2 = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + queryDelay2) {
                self.completion?()
                resultsCompletion(.success(queryResult2))
            }
        } else {
            completion?()
            if let result = self.result {
                resultsCompletion(result)
            }
        }
    }
}
