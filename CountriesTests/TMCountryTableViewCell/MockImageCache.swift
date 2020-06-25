import XCTest
@testable import Countries

class MockImageCache: TMImageCache {
    
    var setImageCompletion: (() -> Void)?
    var cancelImageLoadCompletion: (() -> Void)?
    
    func setImage(at url: URL?, to imageView: UIImageView?) {
        setImageCompletion?()
    }
    
    func cancelImageLoad(for imageView: UIImageView?) {
        cancelImageLoadCompletion?()
    }
}
