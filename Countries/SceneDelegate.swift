import UIKit
import SDWebImageSVGCoder

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: TMCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // Setup SDWebImage to work with SVG.
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
        
        coordinator = TMCoordinator(
            window: window,
            storyboard: UIStoryboard(name: .storyboardName, bundle: nil),
            countriesViewControllerInfo: (.countriesStoryboardID, TMCountriesViewController.self),
            countryViewControllerInfo: (.countryStoryboardID, TMCountryViewController.self),
            sharedImageCache: SDWebImageAsTMImageCache())
        coordinator.setInitialViewController()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

