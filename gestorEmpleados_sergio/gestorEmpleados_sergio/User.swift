
import Foundation

struct User: Decodable{
    let id: Int?
    let name: String?
    let email: String?
    let password: String?
    let workstation: String?
    let token: String?
    let salary: Int?
    let biography: String?
    
    let msg : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case password
        case workstation = "Workstation"
        case token
        case salary
        case biography = "Biography"
        case msg
    }
}
