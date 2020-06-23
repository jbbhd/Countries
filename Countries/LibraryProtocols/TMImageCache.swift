import UIKit

protocol TMImageCache: class {
    
    func setImage(at url: URL?, to imageView: UIImageView?)
    func cancelImageLoad(for imageView: UIImageView?)
}
