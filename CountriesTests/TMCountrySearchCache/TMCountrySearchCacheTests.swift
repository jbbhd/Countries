import XCTest
@testable import Countries

class TMCountrySearchCacheTests: XCTestCase {

    var mockSearcher: MockSearcher!
    var cache: TMCountriesSearchCache!
    
    var nameToSearch = "name"
    
    override func setUpWithError() throws {
        mockSearcher = MockSearcher()
        cache = TMCountriesSearchCache(searcher: mockSearcher)
    }

    override func tearDownWithError() throws {
        cache = nil
    }
    
    func testThatSearchCallSearcher() {
        var didSearch = false
        mockSearcher.completion = {
            didSearch = true
        }
        cache.countriesWithName(nameToSearch) { _ in }
        XCTAssertTrue(didSearch)
    }
    
    func testThatTwoOfTheSameSearchReturnsTheSameResultAndSearchesOnlyOnce () {
        let searchResult = [TMCountry.luxembourg, TMCountry.luxembourg]
        mockSearcher.queryResult1 = searchResult
        mockSearcher.queryDelay1 = 0.0
        mockSearcher.queryResult2 = searchResult
        mockSearcher.queryDelay2 = 0.0
        var numberOfSearches = 0
        mockSearcher.completion = {
            numberOfSearches += 1
        }
        var searchResults: [[TMCountry]] = []
        let expectation = self.expectation(description: "Searches finished.")
        cache.countriesWithName(nameToSearch) { (result) in
            if case .success(let countries) = result {
                searchResults.append(countries)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.cache.countriesWithName(self.nameToSearch) { (result) in
                if case .success(let countries) = result {
                    searchResults.append(countries)
                }
                XCTAssertEqual(searchResults.count, 2)
                XCTAssertEqual(searchResults[0], searchResult)
                XCTAssertEqual(searchResults[1], searchResult)
                XCTAssertEqual(numberOfSearches, 1)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
