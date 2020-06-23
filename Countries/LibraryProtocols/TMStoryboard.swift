import UIKit

protocol TMStoryboard {
    
    func instantiateViewController(withIdentifier identifier: String) -> UIViewController
    func instantiateViewController<ViewController>(identifier: String, creator: ((NSCoder) -> ViewController?)?) -> ViewController where ViewController : UIViewController
}
