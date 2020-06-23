//
//  SceneDelegate.swift
//  Countries
//
//  Created by Jesse Bushyhead on 6/23/20.
//  Copyright © 2020 Jesse Bushyhead. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: TMCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let initialViewControllerInit: TMCoordinator.InitialViewControllerInit = { coder, viewModel, imageCache in
            return TMCountriesViewController(coder: coder, viewModel: viewModel, imageCache: imageCache)
        }
        coordinator = TMCoordinator(window: window, initialViewControllerInit: initialViewControllerInit, sharedImageCache: SDWebImageAsTMImageCache())
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

