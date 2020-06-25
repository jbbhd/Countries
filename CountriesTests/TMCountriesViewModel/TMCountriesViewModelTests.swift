import XCTest
import Combine
@testable import Countries

class TMCountriesViewModelTests: XCTestCase {
            
    var mockSearcher: MockSearcher!
    var mockDelegate: MockSelectionDelegate!
    var viewModel: TMCountriesViewModel!
    
    var cancellable: AnyCancellable?
    
    override func setUpWithError() throws {
        mockSearcher = MockSearcher()
        mockDelegate = MockSelectionDelegate()
        viewModel = TMCountriesViewModel(searcher: mockSearcher, delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testThatQueryChangeCallsSearcher() {
        let expectation = self.expectation(description: "Search was triggered.")
        mockSearcher.completion = {
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        viewModel.didChangeQuery("query")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatQueryChangeCallsAfterTenthSecondDelay() {
        let expectation = self.expectation(description: "Search was triggered.")
        let start = Date()
        mockSearcher.completion = {
            XCTAssertGreaterThanOrEqual(Date().timeIntervalSince(start), 0.1)
            expectation.fulfill()
        }
        viewModel.didChangeQuery("query")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatMultipleSuccessfulSearchesOnlyReturnsResultsOfLastQuery() {
        
        let expectation = self.expectation(description: "Searches finished.")
        
        let queryResult1: [TMCountry] = [.luxembourg, .theVatican]
        let queryDelay1: TimeInterval = 1.5
        let queryResult2: [TMCountry] = [.theVatican]
        let queryDelay2: TimeInterval = 1.0
        self.mockSearcher.queryResult1 = queryResult1
        self.mockSearcher.queryDelay1 = queryDelay1
        self.mockSearcher.queryResult2 = queryResult2
        self.mockSearcher.queryDelay2 = queryDelay2
        
        var numberOfSearchCompletions = 0
        mockSearcher.completion = {
            numberOfSearchCompletions += 1
        }
        
        var numberOfCountriesChanges: [Int] = []
        self.cancellable = viewModel.numberOfCountries.dropFirst().sink { value in
            numberOfCountriesChanges.append(value)
        }
        
        viewModel.didChangeQuery("Search 1")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewModel.didChangeQuery("Search 2")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
            XCTAssertEqual(numberOfSearchCompletions, 2)
            XCTAssertEqual(numberOfCountriesChanges.count, 1)
            XCTAssertEqual(numberOfCountriesChanges[0], queryResult2.count)
            expectation.fulfill()
            self.cancellable?.cancel()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testThatSuccessfulQueryTriggersCorrectNumberOfCountries() {
        let expectation = self.expectation(description: "Search finished.")
        let countries: [TMCountry] = [.luxembourg, .theVatican]
        self.mockSearcher.result = .success(countries)
        self.cancellable = viewModel.numberOfCountries.dropFirst().sink { value in
            XCTAssertEqual(value, countries.count)
            expectation.fulfill()
            self.cancellable?.cancel()
        }
        viewModel.didChangeQuery("query")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatSuccessfulQueryUpdatesCorrectCountryFlagsAndNames() {
        let expectation = self.expectation(description: "Search finished.")
        let countries: [TMCountry] = [.luxembourg, .theVatican]
        self.mockSearcher.result = .success(countries)
        self.cancellable = viewModel.numberOfCountries.dropFirst().sink { value in
            for i in 0..<value {
                XCTAssertEqual(self.viewModel.countryFlagURL(at: i), countries[i].flagURL)
                XCTAssertEqual(self.viewModel.countryName(at: i), countries[i].name)
            }
            expectation.fulfill()
            self.cancellable?.cancel()
        }
        viewModel.didChangeQuery("query")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatDidSelectCountryCallsDelegateWithCorrectCountry() {
        let expectation = self.expectation(description: "Search finished.")
        let countries: [TMCountry] = [.luxembourg, .theVatican]
        var selectedCountries: [TMCountry] = []
        self.mockDelegate.completion = {
            selectedCountries.append($0)
        }
        self.mockSearcher.result = .success(countries)
        self.cancellable = viewModel.numberOfCountries.dropFirst().sink { value in
            for i in 0..<value {
                self.viewModel.didSelectCountry(at: i)
            }
            XCTAssertEqual(countries, selectedCountries)
            expectation.fulfill()
            self.cancellable?.cancel()
        }
        viewModel.didChangeQuery("query")
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
