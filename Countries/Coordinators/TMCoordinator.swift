import UIKit

class TMCoordinator {
        
    typealias RootViewController = TMRootViewController & UIViewController

    typealias CountriesViewControllerInfo = (storyboardID: String, type: (TMCountriesViewControllerIniting & UIViewController).Type)
        
    typealias CountryViewControllerInfo = (storyboardID: String, type: (TMCountryViewControllerIniting & UIViewController).Type)
    
    private let window: TMWindow
    
    private let rootViewController: RootViewController
    
    let storyboard: TMStoryboard
    
    private let countriesViewControllerInfo: CountriesViewControllerInfo
    
    private let countryViewControllerInfo: CountryViewControllerInfo
    
    private let sharedImageCache: TMImageCache
        
    init(
        window: TMWindow,
        rootViewController: RootViewController = UINavigationController(),
        storyboard: TMStoryboard,
        countriesViewControllerInfo: CountriesViewControllerInfo,
        countryViewControllerInfo: CountryViewControllerInfo,
        sharedImageCache: TMImageCache) {
        self.window = window
        self.rootViewController = rootViewController
        self.storyboard = storyboard
        self.countriesViewControllerInfo = countriesViewControllerInfo
        self.countryViewControllerInfo = countryViewControllerInfo
        self.sharedImageCache = sharedImageCache
        window.rootViewController = rootViewController
    }
    
    func setInitialViewController() {
        let initialViewController = storyboard.instantiateViewController(identifier: countriesViewControllerInfo.storyboardID, creator: { coder in
            let countriesAPI = TMRESTCountriesAPI()
            let countriesSearchCache = TMCountriesSearchCache(searcher: countriesAPI)
            let viewModel = TMCountriesViewModel(searcher: countriesSearchCache, delegate: self)
            return self.countriesViewControllerInfo.type.init(coder: coder, viewModel: viewModel, imageCache: self.sharedImageCache)
        })
        rootViewController.pushViewController(initialViewController, animated: false)
        window.makeKeyAndVisible()
    }
}

extension TMCoordinator: TMCountriesViewModelDelegate {
    
    func countriesViewModel(_ viewModel: TMCountriesViewModel, didSelectCountry country: TMCountry) {
        let countryViewController = storyboard.instantiateViewController(identifier: countryViewControllerInfo.storyboardID) { coder in
            let countryViewModel = TMCountryViewModel(country: country)
            return self.countryViewControllerInfo.type.init(coder: coder, viewModel: countryViewModel, imageCache: self.sharedImageCache)
        }
        rootViewController.pushViewController(countryViewController, animated: true)
    }
}
