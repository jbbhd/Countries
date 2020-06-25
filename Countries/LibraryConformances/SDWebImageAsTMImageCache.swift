import UIKit
import SDWebImage

class SDWebImageAsTMImageCache: TMImageCache {
    
    func setImage(at url: URL?, to imageView: UIImageView?) {
        imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: .flagThumbnailImageName), options: [], context: [
            .imagePreserveAspectRatio: true,
            .imageThumbnailPixelSize: CGSize(width: 0, height: 0),
        ])
    }
    
    func cancelImageLoad(for imageView: UIImageView?) {
        imageView?.sd_cancelCurrentImageLoad()
    }
}
