import XCTest
@testable import Countries

class TMCountriesViewControllerTests: XCTestCase {
    
    var mockViewModel: MockCountryViewModel!
    var mockImageCache: MockImageCache!
    var countryViewController: TMCountryViewController!
    
    override func setUpWithError() throws {
        mockViewModel = MockCountryViewModel()
        mockImageCache = MockImageCache()
    }
    
    override func tearDownWithError() throws {
        countryViewController = nil
    }
    
    func setupViewController() {
        countryViewController = TMCountryViewController.createDummyViewController(viewModel: mockViewModel, imageCache: mockImageCache)
    }
    
    func testThatAllMethodsAreCalledOnViewDidLoad() {
        var flagURLDidComplete = false
        var countryNameDidComplete = false
        var capitalTitleTextDidComplete = false
        var callingCodeTitleTextDidComplete = false
        var regionTitleTextDidComplete = false
        var subregionTitleTextDidComplete = false
        var timeZonesTitleTextDidComplete = false
        var currenciesTitleTextDidComplete = false
        var languagesTitleTextDidComplete = false
        var capitalTextDidComplete = false
        var callingCodeTextDidComplete = false
        var regionTextDidComplete = false
        var subregionTextDidComplete = false
        var timeZonesTextDidComplete = false
        var currenciesTextDidComplete = false
        var languagesTextDidComplete = false
        mockViewModel.flagURLCompletion = {
            flagURLDidComplete = true
        }
        mockViewModel.countryNameCompletion = {
            countryNameDidComplete = true
        }
        mockViewModel.capitalTitleTextCompletion = {
            capitalTitleTextDidComplete = true
        }
        mockViewModel.callingCodeTitleTextCompletion = {
            callingCodeTitleTextDidComplete = true
        }
        mockViewModel.regionTitleTextCompletion = {
            regionTitleTextDidComplete = true
        }
        mockViewModel.subregionTitleTextCompletion = {
            subregionTitleTextDidComplete = true
        }
        mockViewModel.timeZonesTitleTextCompletion = {
            timeZonesTitleTextDidComplete = true
        }
        mockViewModel.currenciesTitleTextCompletion = {
            currenciesTitleTextDidComplete = true
        }
        mockViewModel.languagesTitleTextCompletion = {
            languagesTitleTextDidComplete = true
        }
        mockViewModel.capitalTextCompletion = {
            capitalTextDidComplete = true
        }
        mockViewModel.callingCodeTextCompletion = {
            callingCodeTextDidComplete = true
        }
        mockViewModel.regionTextCompletion = {
            regionTextDidComplete = true
        }
        mockViewModel.subregionTextCompletion = {
            subregionTextDidComplete = true
        }
        mockViewModel.timeZonesTextCompletion = {
            timeZonesTextDidComplete = true
        }
        mockViewModel.currenciesTextCompletion = {
            currenciesTextDidComplete = true
        }
        mockViewModel.languagesTextCompletion = {
            languagesTextDidComplete = true
        }
        setupViewController()
        countryViewController.loadViewIfNeeded()
        XCTAssertTrue(flagURLDidComplete)
        XCTAssertTrue(countryNameDidComplete)
        XCTAssertTrue(capitalTitleTextDidComplete)
        XCTAssertTrue(callingCodeTitleTextDidComplete)
        XCTAssertTrue(regionTitleTextDidComplete)
        XCTAssertTrue(subregionTitleTextDidComplete)
        XCTAssertTrue(timeZonesTitleTextDidComplete)
        XCTAssertTrue(currenciesTitleTextDidComplete)
        XCTAssertTrue(languagesTitleTextDidComplete)
        XCTAssertTrue(capitalTextDidComplete)
        XCTAssertTrue(callingCodeTextDidComplete)
        XCTAssertTrue(regionTextDidComplete)
        XCTAssertTrue(subregionTextDidComplete)
        XCTAssertTrue(timeZonesTextDidComplete)
        XCTAssertTrue(currenciesTextDidComplete)
        XCTAssertTrue(languagesTextDidComplete)
    }
}
