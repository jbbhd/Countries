import UIKit

private extension String {
    
    static let storyboardName = "Main"
    static let countriesStoryboardID = "TMCountriesViewController"
    static let countryStoryboardID = "TMCountryViewController"
}

class TMCoordinator {
    
    typealias InitialViewControllerInit = (NSCoder, TMCountriesViewModeling, TMImageCache) -> UIViewController
    
    typealias RootViewController = TMRootViewController & UIViewController

    typealias CountriesViewController = TMCountriesViewControllerIniting & UIViewController
    
    typealias CountryViewController = TMCountryViewControllerIniting & UIViewController
    
    private let window: TMWindow
    
    private let rootViewController: RootViewController
    
    private let storyboard: TMStoryboard
    
    private let countriesViewControllerType: CountriesViewController.Type
    
    private let countryViewControllerType: CountryViewController.Type
    
    private let sharedImageCache: TMImageCache
        
    init(
        window: TMWindow,
        rootViewController: RootViewController = UINavigationController(),
        storyboard: TMStoryboard = UIStoryboard(name: .storyboardName, bundle: nil),
        countriesViewControllerType: CountriesViewController.Type,
        countryViewControllerType: CountryViewController.Type,
        sharedImageCache: TMImageCache) {
        self.window = window
        self.rootViewController = rootViewController
        self.storyboard = UIStoryboard(name: .storyboardName, bundle: nil)
        self.countriesViewControllerType = countriesViewControllerType
        self.countryViewControllerType = countryViewControllerType
        self.sharedImageCache = sharedImageCache
        window.rootViewController = rootViewController
    }
    
    func setInitialViewController() {
        let initialViewController = storyboard.instantiateViewController(identifier: .countriesStoryboardID, creator: { coder in
            let countriesAPI = TMRESTCountriesAPI()
            let countriesSearchCache = TMCountriesSearchCache(searcher: countriesAPI)
            let viewModel = TMCountriesViewModel(searcher: countriesSearchCache, selectionDelegate: self)
            return self.countriesViewControllerType.init(coder: coder, viewModel: viewModel, imageCache: self.sharedImageCache)
        })
        rootViewController.pushViewController(initialViewController, animated: false)
        window.makeKeyAndVisible()
    }
}

extension TMCoordinator: TMCountriesViewModelDelegate {
    
    func countriesViewModel(_ viewModel: TMCountriesViewModel, didSelectCountry country: TMCountry) {
        let countryViewController = storyboard.instantiateViewController(identifier: .countryStoryboardID) { coder in
            let countryViewModel = TMCountryViewModel(country: country)
            return self.countryViewControllerType.init(coder: coder, viewModel: countryViewModel, imageCache: self.sharedImageCache)
        }
        rootViewController.pushViewController(countryViewController, animated: true)
    }
}
