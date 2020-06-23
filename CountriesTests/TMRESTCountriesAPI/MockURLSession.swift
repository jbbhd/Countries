import UIKit
@testable import Countries

class MockURLSession: TMURLSession {
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var mockDataTask: URLSessionDataTask!
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        DispatchQueue.main.async {
            completionHandler(self.data, self.urlResponse, self.error)
        }
        return mockDataTask
    }
}
