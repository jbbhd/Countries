import XCTest
@testable import Countries

class TMRESTCountriesAPITests: XCTestCase {
    
    var urlForURLFromString: URL?
    var mockJSONDecoder: MockJSONDecoder!
    var mockURLSessionDataTask: MockURLSessionDataTask!
    var mockURLSession: MockURLSession!
    var nameToSearch = ""
    var api: TMRESTCountriesAPI!

    let data = "12345".data(using: .ascii)!
    let response = MockHTTPURLResponse(statusCode: 200)
    let error: Error = NSError(domain: "999", code: 999, userInfo: nil)
    
    override func setUpWithError() throws {
        urlForURLFromString = URL(string: "https://www.google.com/")
        mockJSONDecoder = MockJSONDecoder()
        mockURLSessionDataTask = MockURLSessionDataTask()
        mockURLSession = MockURLSession()
        mockURLSession.data = data
        mockURLSession.urlResponse = response
        mockURLSession.error = nil
        mockURLSession.mockDataTask = mockURLSessionDataTask
        nameToSearch = "United"
        api = TMRESTCountriesAPI(urlSession: mockURLSession, urlFromString: { _ in return self.urlForURLFromString }, jsonDecoder: mockJSONDecoder)
    }

    override func tearDownWithError() throws {
        api = nil
    }
    
    func testThatCountrySearchSucceedsWithDefaultValues() {
        let expectation = self.expectation(description: "Search countries finishes.")
        api.searchByName(nameToSearch) { (result) in
            XCTAssertTrue(result.isSuccess())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatCountrySearchFailsWithEmptyString() {
        nameToSearch = ""
        let expectation = self.expectation(description: "Search countries finishes.")
        api.searchByName(nameToSearch) { (result) in
            XCTAssertTrue(result.isFailure())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatCountrySearchFailsWithUnPercentEncodableString() {
        // FIXME: Implement.
    }
    
    func testThatCountrySearchFailsIfURLFromStringFails() {
        urlForURLFromString = nil
        let expectation = self.expectation(description: "Search countries finishes.")
        api.searchByName(nameToSearch) { (result) in
            XCTAssertTrue(result.isFailure())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatCountrySearchFailsIfTaskErrors() {
        mockURLSession.error = error
        let expectation = self.expectation(description: "Search countries finishes.")
        api.searchByName(nameToSearch) { (result) in
            XCTAssertTrue(result.isFailure())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testThatCountrySearchFailsIfTaskFailsWithStatusCodeNot200() {
        mockURLSession.urlResponse = MockHTTPURLResponse(statusCode: 0)
        let expectation = self.expectation(description: "Search countries finishes.")
        api.searchByName(nameToSearch) { (result) in
            XCTAssertTrue(result.isFailure())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatCountrySearchErrorsIfDataIsNil() {
        mockURLSession.data = nil
        let expectation = self.expectation(description: "Search countries finishes.")
        api.searchByName(nameToSearch) { (result) in
            XCTAssertTrue(result.isFailure())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatCountrySearchErrorsIfJSONDecoderThrows() {
        mockJSONDecoder.error = error
        let expectation = self.expectation(description: "Search countries finishes.")
        api.searchByName(nameToSearch) { (result) in
            XCTAssertTrue(result.isFailure())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testThatCountrySearchStartsTheURLSessionDataTask() {
        var didResume = false
        mockURLSessionDataTask.resumeCompletion = { didResume = true }
        api.searchByName(nameToSearch) { (result) in }
        XCTAssertTrue(didResume)
    }
}
