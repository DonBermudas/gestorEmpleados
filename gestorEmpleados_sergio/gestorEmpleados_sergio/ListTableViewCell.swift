
import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    func setCellWithValueOf(_ employee: User){
        updateUI(employeeName: employee.name, employeeWorkstation: employee.workstation, salary: employee.salary)
    }
    
    private func updateUI(employeeName: String?, employeeWorkstation: String?, salary: Int?){
        self.nameLabel.text = employeeName
        self.jobLabel.text = employeeWorkstation
        if let salary = salary {
            self.salaryLabel.text = String(salary)
            
        }
    }
}
