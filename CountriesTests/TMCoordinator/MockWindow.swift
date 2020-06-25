import XCTest
@testable import Countries

class MockWindow: TMWindow {

    var rootViewControllerGetCompletion: (() -> Void)?
    var rootViewControllerSetCompletion: ((UIViewController?) -> Void)?
    var makeKeyAndVisibleCompletion: (() -> Void)?

    var rootViewController: UIViewController? {
        get {
            rootViewControllerGetCompletion?()
            return nil
        } set (newValue) {
            rootViewControllerSetCompletion?(newValue)
        }
    }
    
    func makeKeyAndVisible() {
        makeKeyAndVisibleCompletion?()
    }
}
