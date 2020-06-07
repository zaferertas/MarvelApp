

import XCTest
@testable import MarvelApp

class MockApiService: ApiService {

    var isSuccess = true
    
    func fetchCharacters(searchKey: String, limit: Int, offset: Int, completion: @escaping(Result<[Character], FetchError>) -> Void) {
        
        if isSuccess {
            completion(.success(MockApiService.mockCharacters))
        } else {
            completion(.failure(FetchError.invalidData))
        }
    }
    
    static let mockCharacters = [
        Character(id: 0, name: "name1", description: "description1", modified: "", thumbnail: Thumbnail(path: "", ext: ""), resourceURI: "", comics: nil, series: nil, stories: nil, events: nil, urls: [HeroURL(type: "", url: "")]),
        Character(id: 1, name: "name2", description: "description2", modified: "", thumbnail: Thumbnail(path: "", ext: ""), resourceURI: "", comics: nil, series: nil, stories: nil, events: nil, urls: [HeroURL(type: "", url: "")]),
        Character(id: 2, name: "name3", description: "description3", modified: "", thumbnail: Thumbnail(path: "", ext: ""), resourceURI: "", comics: nil, series: nil, stories: nil, events: nil, urls: [HeroURL(type: "", url: "")])
    ]
}


