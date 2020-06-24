import UIKit

class TMCountryViewController: UIViewController {

    @IBOutlet private weak var flagImageView: UIImageView!
 
    @IBOutlet private weak var capitalTitleLabel: UILabel!
    
    @IBOutlet private weak var callingCodeTitleLabel: UILabel!
    
    @IBOutlet private weak var regionTitleLabel: UILabel!
    
    @IBOutlet private weak var subregionTitleLabel: UILabel!
    
    @IBOutlet private weak var timeZonesTitleLabel: UILabel!
    
    @IBOutlet private weak var currenciesTitleLabel: UILabel!
    
    @IBOutlet private weak var languagesTitleLabel: UILabel!
    
    @IBOutlet private weak var capitalLabel: UILabel!
    
    @IBOutlet private weak var callingCodeLabel: UILabel!
    
    @IBOutlet private weak var regionLabel: UILabel!
    
    @IBOutlet private weak var subregionLabel: UILabel!
    
    @IBOutlet private weak var timeZonesLabel: UILabel!
    
    @IBOutlet private weak var currenciesLabel: UILabel!
    
    @IBOutlet private weak var languagesLabel: UILabel!
    
    private var viewModel: TMCountryViewModeling!
    
    private var imageCache: TMImageCache!
    
    required init(coder: NSCoder, viewModel: TMCountryViewModeling, imageCache: TMImageCache) {
        super.init(coder: coder)!
        self.viewModel = viewModel
        self.imageCache = imageCache
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCache.setImage(at: viewModel.flagURL, to: flagImageView)
        
        navigationItem.title        = viewModel.countryName
        
        capitalTitleLabel.text      = viewModel.capitalTitleText
        callingCodeTitleLabel.text  = viewModel.callingCodeTitleText
        regionTitleLabel.text       = viewModel.regionTitleText
        subregionTitleLabel.text    = viewModel.subregionTitleText
        timeZonesTitleLabel.text    = viewModel.timeZonesTitleText
        currenciesTitleLabel.text   = viewModel.currenciesTitleText
        languagesTitleLabel.text    = viewModel.languagesTitleText
        
        capitalLabel.text           = viewModel.capitalText
        callingCodeLabel.text       = viewModel.callingCodeText
        regionLabel.text            = viewModel.regionText
        subregionLabel.text         = viewModel.subregionText
        timeZonesLabel.text         = viewModel.timeZonesText
        currenciesLabel.text        = viewModel.currenciesText
        languagesLabel.text         = viewModel.languagesText
    }
}

extension TMCountryViewController: TMCountryViewControllerIniting {
    
}
