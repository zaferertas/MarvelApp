
import Foundation

struct MarvelInfo: Decodable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Decodable, Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let description: String
    var modified: String?
    let thumbnail: Thumbnail
    var resourceURI: String?
    var comics: ComicList?
    var series: SeriesList?
    var stories: StoryList?
    var events: EventList?
    let urls: [HeroURL]
}

struct Thumbnail: Decodable {
    let path: String
    let ext: String

    var url: String {
        return path + "." + ext
    }

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }

}
struct ComicList: Decodable {
    var available: Int?
    var collectionURI: String?
    var items: [ComicSummary]?
    var returned: Int?
}

struct ComicSummary: Decodable {
    var resourceURI: String?
    var name: String?
}

struct StoryList: Decodable {
    var available: Int?
    var collectionURI: String?
    var items: [StorySummary]?
    var returned: Int?
}

struct StorySummary: Decodable {
    var resourceURI: String?
    var name: String?
    var type: String?
}

struct EventList: Decodable {
    var available: Int?
    var collectionURI: String?
    var items: [EventSummary]?
    var returned: Int?
}

struct EventSummary: Decodable {
    var resourceURI: String?
    var name: String?
}

struct SeriesList: Decodable {
    var available: Int?
    var collectionURI: String?
    var items: [SeriesSummary]?
    var returned: Int?
}

struct SeriesSummary: Decodable {
    var resourceURI: String?
    var name: String?
}

struct HeroURL: Decodable {
    let type: String
    let url: String
}
