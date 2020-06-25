import UIKit

class TMCountryTableViewCell: UITableViewCell {

    static func createDummyCell() -> TMCountryTableViewCell {
        return TMCountryTableViewCell()
    }
    
    @IBOutlet private weak var flagImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    private var imageCache: TMImageCache?
    
    private init() {
        super.init(style: .default, reuseIdentifier: nil)
        let flagImageView = UIImageView()
        let nameLabel = UILabel()
        contentView.addSubview(flagImageView)
        contentView.addSubview(nameLabel)
        self.flagImageView = flagImageView
        self.nameLabel = nameLabel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
        imageCache?.cancelImageLoad(for: flagImageView)
        imageView?.image = nil
        if let url = url {
            imageCache?.setImage(at: url, to: flagImageView)
        }
    }
}
