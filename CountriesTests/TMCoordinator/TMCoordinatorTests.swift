import XCTest
import Combine
@testable import Countries

class TMCoordinatorTests: XCTestCase {

    var mockWindow: MockWindow!
    var mockRootViewController: MockRootViewController!
    var mockStoryboard: MockStoryboard!
    var mockImageCache: MockImageCache!
    var countriesViewControllerStoryboardID = "ID1"
    var countriesViewControllerType = TMCountriesViewController.self
    var countryViewControllerStoryboardID = "ID2"
    var countryViewControllerType = TMCountryViewController.self
    var coordinator: TMCoordinator!
        
    override func setUpWithError() throws {
        mockWindow = MockWindow()
        mockRootViewController = MockRootViewController()
        mockStoryboard = MockStoryboard()
        mockImageCache = MockImageCache()
    }

    override func tearDownWithError() throws {
        coordinator = nil
    }
    
    func setupCoordinator() {
        coordinator = TMCoordinator(
            window: mockWindow,
            rootViewController: mockRootViewController,
            storyboard: mockStoryboard,
            countriesViewControllerInfo: (countriesViewControllerStoryboardID, self.countriesViewControllerType),
            countryViewControllerInfo: (countryViewControllerStoryboardID, self.countryViewControllerType),
            sharedImageCache: mockImageCache)
    }
    
    func testThatTheRootViewControllerIsSetWithRootViewControllerInInit() {
        var didSetToRootViewController = false
        mockWindow.rootViewControllerSetCompletion = { vc in
            didSetToRootViewController = vc === self.mockRootViewController
        }
        setupCoordinator()
        XCTAssertTrue(didSetToRootViewController)
    }
    
    func testThatSetInitialViewControllerGivesCorrectStoryboardID() {
        var didGiveCorrectStoryboardID = false
        mockStoryboard.storyboardIDCompletion = { id in
            didGiveCorrectStoryboardID = self.countriesViewControllerStoryboardID == id
        }
        setupCoordinator()
        coordinator.setInitialViewController()
        XCTAssertTrue(didGiveCorrectStoryboardID)
    }
    
    func testThatSetInitialViewControllerSetsCorrectViewControllerInRootViewController() {
        var didPushCorrectViewController = false
        let viewController = UIViewController()
        mockStoryboard.result = viewController
        mockRootViewController.pushViewControllerCompletion = { vc in
            didPushCorrectViewController = viewController === vc
        }
        setupCoordinator()
        coordinator.setInitialViewController()
        XCTAssertTrue(didPushCorrectViewController)
    }
    
    func testThatDidSelectCountriesGivesCorrectStoryboardID() {
        var didGiveCorrectStoryboardID = false
        setupCoordinator()
        coordinator.setInitialViewController()
        mockStoryboard.storyboardIDCompletion = { id in
            didGiveCorrectStoryboardID = self.countryViewControllerStoryboardID == id
        }
        let throwaway = TMCountriesViewModel(searcher: TMRESTCountriesAPI(), delegate: nil)
        coordinator.countriesViewModel(throwaway, didSelectCountry: .luxembourg)
        XCTAssertTrue(didGiveCorrectStoryboardID)
    }
    
    func testThatDidSelectCountriesAddsViewControllerInRootViewController() {
        var didPushCorrectViewController = false
        let viewController = UIViewController()
        setupCoordinator()
        coordinator.setInitialViewController()
        mockStoryboard.result = viewController
        mockRootViewController.pushViewControllerCompletion = { vc in
            didPushCorrectViewController = vc === viewController
        }
        let throwaway = TMCountriesViewModel(searcher: TMRESTCountriesAPI(), delegate: nil)
        coordinator.countriesViewModel(throwaway, didSelectCountry: .luxembourg)
        XCTAssertTrue(didPushCorrectViewController)
    }
}
