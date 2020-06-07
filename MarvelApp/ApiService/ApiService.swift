
import Foundation
import Alamofire
import CryptoSwift

protocol ApiService {
    func fetchCharacters(searchKey: String, limit: Int, offset: Int, completion: @escaping(Result<[Character], FetchError>) -> Void)
}

class MarvelApiService: ApiService {

    func fetchCharacters(searchKey: String, limit: Int, offset: Int, completion: @escaping(Result<[Character], FetchError>) -> Void) {
        
        let params = buildParams(searchKey: searchKey, limit: limit, offset: offset)
        let url = buildURL()

        AF.request(url, parameters: params)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(FetchError.invalidData))
                            return
                        }
                        let result = try JSONDecoder().decode(MarvelInfo.self, from: data)
                        completion(.success((result.data.results)))
                    } catch {
                        completion(.failure(.parseError))
                    }
                case .failure(let error):
                    completion(.failure(.customError(error)))
                }
            }
    }
}

extension MarvelApiService {
    
    private func buildURL() -> String {
        return MarvelApiConstants.baseUrl + MarvelApiConstants.charactersPath
    }
    
    private func buildParams(searchKey: String, limit: Int, offset: Int) -> [String: Any] {
        
        var params = [String: Any]()
        
        let timeStamp = Int(Date().timeIntervalSince1970)
        params["ts"] = timeStamp
        params["apikey"] = MarvelApiConstants.publicKey
        params["hash"] = getHash(ts: timeStamp)
        if searchKey != "" {
            params["nameStartsWith"] = searchKey
        }
        params["limit"] = limit
        params["offset"] = offset
        
        return params
    }

    private func getHash(ts: Int) -> String {
        let hash = "\(ts)\(MarvelApiConstants.privateKey)\(MarvelApiConstants.publicKey)"
        return hash.md5()
    }
}
