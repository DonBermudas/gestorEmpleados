
import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileUser()
    }
    
    //Outlets
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var workProfile: UILabel!
    @IBOutlet weak var salaryProfile: UILabel!
    @IBOutlet weak var bioProfile: UILabel!
    
    //Variables
    var profileName : String? = ""
    var profileWork : String? = ""
    var profileSalary : Int?
    var profileBio: String? = ""
    
    func profileUser(){
        NetworkingProvider.shared.employeeProfile { data, status in
            if let profileName = data?.name , let profileWork = data?.workstation , let profileSalary = data?.salary, let profileBio = data?.biography{
                
                self.nameProfile.text = profileName
                self.workProfile.text = profileWork
                self.salaryProfile.text = String(profileSalary)
                self.bioProfile.text = profileBio
            }
        } failure: { error in
            print(error)
        }

    }
}
