import UIKit
import SDWebImage

class SDWebImageAsTMImageCache: TMImageCache {
    
    func setImage(at url: URL?, to imageView: UIImageView?) {
        imageView?.sd_setImage(with: url, completed: nil)
    }
    
    func cancelImageLoad(for imageView: UIImageView?) {
        imageView?.sd_cancelCurrentImageLoad()
    }
}
