import XCTest
@testable import Countries

class MockRootViewController: UIViewController, TMRootViewController {
    
    var pushViewControllerCompletion: ((UIViewController) -> Void)?
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCompletion?(viewController)
    }
}
