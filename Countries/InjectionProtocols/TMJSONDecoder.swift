import UIKit

protocol TMJSONDecoder {
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}