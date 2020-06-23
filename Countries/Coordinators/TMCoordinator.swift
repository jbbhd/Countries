import UIKit

private extension String {
    
    static let storyboardName = "Main"
    static let countriesStoryboardID = "TMCountriesViewController"
}

class TMCoordinator {
    
    typealias InitialViewControllerInit = (NSCoder, TMCountriesViewModel, TMImageCache) -> UIViewController
    
    typealias RootViewController = TMRootViewController & UIViewController

    private let window: TMWindow
    
    private let rootViewController: RootViewController
    
    private let storyboard: TMStoryboard
    
    private let initialViewControllerInit: InitialViewControllerInit
    
    private let sharedImageCache: TMImageCache
        
    init(
        window: TMWindow,
        rootViewController: RootViewController = UINavigationController(),
        storyboard: TMStoryboard = UIStoryboard(name: .storyboardName, bundle: nil),
        initialViewControllerInit: @escaping InitialViewControllerInit,
        sharedImageCache: TMImageCache) {
        self.window = window
        self.rootViewController = rootViewController
        self.storyboard = UIStoryboard(name: .storyboardName, bundle: nil)
        self.initialViewControllerInit = initialViewControllerInit
        self.sharedImageCache = sharedImageCache
        window.rootViewController = rootViewController
    }
    
    func setInitialViewController() {
        let initialViewController = storyboard.instantiateViewController(identifier: .countriesStoryboardID, creator: { coder in
            let countriesAPI = TMRESTCountriesAPI()
            let countriesSearchCache = TMCountriesSearchCache(searcher: countriesAPI)
            let viewModel = TMCountriesViewModelImpl(searcher: countriesSearchCache, selectionDelegate: self)
            return self.initialViewControllerInit(coder, viewModel, self.sharedImageCache)
        })
        rootViewController.pushViewController(initialViewController, animated: false)
        window.makeKeyAndVisible()
    }
}

extension TMCoordinator: TMCountriesViewModelImplDelegate {
    
    func countriesViewModel(_ viewModel: TMCountriesViewModelImpl, didSelectCountry country: TMCountry) {
        // FIXME
    }
}
