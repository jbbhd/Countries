import XCTest
@testable import Countries

class TMCountryTableViewCellTests: XCTestCase {

    var mockImageCache: MockImageCache!
    var cell: TMCountryTableViewCell!
    
    
    override func setUpWithError() throws {
        mockImageCache = MockImageCache()
        cell = TMCountryTableViewCell.createDummyCell()
        cell.setImageCache(mockImageCache)
    }

    override func tearDownWithError() throws {
        cell = nil
    }
    
    func testThatPrepareForReuseCancelsImageLoad() {
        var didCancel = false
        mockImageCache.cancelImageLoadCompletion = {
            didCancel = true
        }
        cell.prepareForReuse()
        XCTAssertTrue(didCancel)
    }
    
    func testThatSettingEmptyFlagURLCancelsImageLoad() {
        var didCancel = false
        mockImageCache.cancelImageLoadCompletion = {
            didCancel = true
        }
        cell.setFlagURL(nil)
        XCTAssertTrue(didCancel)
    }
    
    func testThatSettingFlagURLCancelsThenStartsImageLoad() {
        var didCancelTime: Date?
        var didStartTime: Date?
        mockImageCache.cancelImageLoadCompletion = {
            didCancelTime = Date()
        }
        mockImageCache.setImageCompletion = {
            didStartTime = Date()
        }
        cell.setFlagURL(URL(string: "http://www.google.com/")!)
        XCTAssertNotNil(didCancelTime)
        XCTAssertNotNil(didStartTime)
        XCTAssertGreaterThan(didStartTime!.timeIntervalSince1970, didCancelTime!.timeIntervalSince1970)
    }
}
