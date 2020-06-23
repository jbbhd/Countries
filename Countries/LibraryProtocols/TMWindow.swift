import UIKit

protocol TMWindow: class {
    
    var rootViewController: UIViewController? { get set }
    func makeKeyAndVisible()
}
