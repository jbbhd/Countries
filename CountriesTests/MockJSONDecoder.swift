import UIKit
@testable import Countries

class MockJSONDecoder: TMJSONDecoder {

    var result: [TMCountry] = []
    
    var error: Error?
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let error = error {
            throw error
        }
        return result as! T
    }
}
