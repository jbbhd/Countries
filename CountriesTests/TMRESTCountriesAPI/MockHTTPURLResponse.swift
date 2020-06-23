import UIKit
@testable import Countries

class MockHTTPURLResponse: HTTPURLResponse {
    
    init(statusCode: Int) {
        super.init(url: URL(string: "https://www.google.com/")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
