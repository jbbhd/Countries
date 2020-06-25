import XCTest
@testable import Countries

class MockStoryboard: TMStoryboard {
    
    var storyboardIDCompletion: ((String) -> Void)?
    var result: UIViewController?
    
    func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
        storyboardIDCompletion?(identifier)
        return result ?? UIViewController()
    }
    
    func instantiateViewController<ViewController>(identifier: String, creator: ((NSCoder) -> ViewController?)?) -> ViewController where ViewController : UIViewController {
        storyboardIDCompletion?(identifier)
        return (result ?? UIViewController()) as! ViewController
    }
}
