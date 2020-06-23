import UIKit

protocol TMJSONDecoder: class {
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}
