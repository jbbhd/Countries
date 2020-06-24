import UIKit

class TMCountryTableViewCell: UITableViewCell {

    @IBOutlet private weak var flagImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    private var imageCache: TMImageCache?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setName(nil)
        setFlagURL(nil)
    }
    
    func setImageCache(_ imageCache: TMImageCache) {
        self.imageCache = imageCache
    }
    
    
    func setName(_ name: String?) {
        nameLabel.text = name
    }

    func setFlagURL(_ url: URL?) {
        if let url = url {
            imageCache?.setImage(at: url, to: flagImageView)
        } else {
            imageCache?.cancelImageLoad(for: flagImageView)
            flagImageView.image = nil
        }
    }
}
