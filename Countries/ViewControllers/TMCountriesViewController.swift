import UIKit
import Combine

private extension String {
    
    static let cell = "cell"
}

class TMCountriesViewController: UITableViewController {
    
    private var viewModel: TMCountriesViewModel!
     
    private var imageCache: TMImageCache!
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    init(coder: NSCoder, viewModel: TMCountriesViewModel, imageCache: TMImageCache) {
        super.init(coder: coder)!
        self.viewModel = viewModel
        self.imageCache = imageCache
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCountry(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cell, for: indexPath)
        imageCache.setImage(at: viewModel.countryFlagURL(at: indexPath.row), to: cell.imageView)
        cell.textLabel?.text = viewModel.countryName(at: indexPath.row)
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
