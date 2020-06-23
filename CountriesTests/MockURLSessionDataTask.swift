import UIKit
@testable import Countries

class MockURLSessionDataTask: URLSessionDataTask {
    
    var resumeCompletion: (() -> Void)?
    
    init(resumeCompletion: (() -> Void)? = nil) {
        self.resumeCompletion = resumeCompletion
    }
    
    override func resume() {
        resumeCompletion?()
    }
}
