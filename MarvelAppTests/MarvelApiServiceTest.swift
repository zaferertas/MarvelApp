
import XCTest
@testable import MarvelApp

class MarvelApiServiceTest: XCTestCase {

    var apiService: ApiService?
    
    override func setUp() {
        super.setUp()
        apiService = MarvelApiService()
    }

    override func tearDown() {
        apiService = nil
        super.tearDown()
    }

    func test_fetch_marvel_characters() {

        let apiService = self.apiService!

        let expect = XCTestExpectation(description: "callback")
        
        apiService.fetchCharacters(searchKey: "", limit: 20, offset: 0)  { (result) in

            expect.fulfill()
            
            switch result {
                case .success(let data):
                    XCTAssertEqual( data.count, 20)
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
            }
        
        wait(for: [expect], timeout: 4.1)
    }

}

