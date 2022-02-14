
import Foundation

struct Response: Decodable{
    let status: Int?
    let data: User?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

struct ListResponse: Decodable{
    let status: Int?
    let data: [User]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}
