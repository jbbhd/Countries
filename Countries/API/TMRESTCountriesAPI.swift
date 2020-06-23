import UIKit

class TMRESTCountriesAPI {

    static var shared: TMRESTCountriesAPI?
    
    private let countrySearchPrefix = "https://restcountries.eu/rest/v2/name/"
    
    let urlSession: TMURLSession
    
    let urlFromString: (String) -> URL?
    
    let jsonDecoder: TMJSONDecoder
    
    init(
        urlSession: TMURLSession = URLSession.shared,
        urlFromString: @escaping (String) -> URL? = URL.init(string:),
        jsonDecoder: TMJSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.urlFromString = urlFromString
        self.jsonDecoder = jsonDecoder
    }
    
    func countriesWithName(_ countryName: String, completion: @escaping (Result<[TMCountry], TMError>) -> Void) {
        guard !countryName.isEmpty else { return completion(.failure(.standard) )}
        guard let encodedName = countryName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else { return completion(.failure(.standard) )}
        guard let url = urlFromString("\(countrySearchPrefix)\(encodedName)") else { return completion(.failure(.standard)) }
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return completion(.failure(.wrapped(error)))
            }
            guard let httpResponse = response as? HTTPURLResponse else { return completion(.failure(.standard)) }
            guard httpResponse.statusCode == 200 else { return completion(.failure(.statusCode(httpResponse.statusCode))) }
            guard let data = data else { return completion(.failure(.standard)) }
            do {
                return completion(.success(try self.jsonDecoder.decode([TMCountry].self, from: data)))
            } catch {
                return completion(.failure(.wrapped(error)))
            }
        }.resume()
    }
}

extension TMRESTCountriesAPI: TMCountriesSearcher {
    
}

