
import XCTest
import RxSwift
import RxTest
@testable import MarvelApp

class MasterViewModelTest: XCTestCase {

    var viewModel: MasterViewModel!
    var mockAPIService: MockApiService!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        viewModel = MasterViewModel(apiService: mockAPIService)
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_is_fetching() {

        let isFetchingObserver = scheduler.createObserver(Bool.self)

        viewModel.isFetching
            .drive(isFetchingObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        viewModel.loadCharacters()

        XCTAssertEqual(isFetchingObserver.events, [.next(0, false), .next(0, true), .next(0, false)])
    }
    
    func test_fetch_characters_with_success() {

        mockAPIService.isSuccess = true
        let charactersObserver = scheduler.createObserver([Character].self)

        viewModel.characters
            .drive(charactersObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        viewModel.loadCharacters()

        XCTAssertEqual(charactersObserver.events, [.next(0, []), .next(0, MockApiService.mockCharacters)])
        
    }
    
    func test_fetch_error() {

        mockAPIService.isSuccess = false
        let errorObserver = scheduler.createObserver(String?.self)

        viewModel.error
            .drive(errorObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        viewModel.loadCharacters()

        XCTAssertEqual(errorObserver.events, [.next(0, nil), .next(0, FetchError.invalidData.errorDescription)])
    }

}
