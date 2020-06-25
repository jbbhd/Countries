import UIKit
import Combine

private extension String {
    
    static let cell = "cell"
}

class TMCountriesViewController: UITableViewController {
    
    private var viewModel: TMCountriesViewModeling!
     
    private var imageCache: TMImageCache!
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var observerHandle: AnyCancellable?
    
    required init(coder: NSCoder, viewModel: TMCountriesViewModeling, imageCache: TMImageCache) {
        super.init(coder: coder)!
        self.viewModel = viewModel
        self.imageCache = imageCache
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        observerHandle?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observerHandle = viewModel.numberOfCountries.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCountries.value
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCountry(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cell, for: indexPath) as! TMCountryTableViewCell
        cell.setImageCache(imageCache)
        cell.setFlagURL(viewModel.countryFlagURL(at: indexPath.row))
        cell.setName(viewModel.countryName(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        imageCache.cancelImageLoad(for: cell.imageView)
    }
}

extension TMCountriesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didChangeQuery(searchText)
    }
}

extension TMCountriesViewController: TMCountriesViewControllerIniting {
    
}
