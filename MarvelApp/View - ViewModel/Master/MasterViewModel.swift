
import Foundation
import RxSwift
import RxCocoa

class MasterViewModel {

    var coordinator: AppCoordinator?
    private let apiService: ApiService
    
    private let _characters = BehaviorRelay<[Character]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    private let defaultSearchKey = ""
    private let defaultFetchLimit = 20
    private let defaultFetchOffset = 0
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var characters: Driver<[Character]> {
        return _characters.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    init(apiService: ApiService) {
        self.apiService = apiService

    }
    
    func loadCharacters() {
        
        self._isFetching.accept(true)
        
        apiService.fetchCharacters(searchKey: defaultSearchKey, limit: defaultFetchLimit, offset: defaultFetchOffset)  { (result) in
            
            self._isFetching.accept(false)
            
            switch result {
                case .success(let data):
                    self._characters.accept(data)
                case .failure(let error):
                    self._error.accept(error.errorDescription)
                }
            }
    }
    func goToDetailsView(character: Character) {
        coordinator?.showDetailsView(character: character)
    }
}
