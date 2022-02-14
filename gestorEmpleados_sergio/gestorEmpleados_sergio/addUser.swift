
import Foundation

struct AddUser: Encodable{
    
    let name: String?
    let email: String?
    let password: String?
    let Workstation: String?
    let salary: Int?
    let biography: String?
    let created_at: Date?
    let updated_at: Date?
}
