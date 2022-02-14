
import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    var email:String?
    var password:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     Función de Login
     */
    @IBAction func loginButton(_ sender: UIButton) {
        
        email = emailTf.text
        password = passwordTf.text
        
        if let email = email, let password = password {

            if(email == "" || password == ""){
                self.showToast(message: "Email o password incorrecto", font: .systemFont(ofSize: 12.0))
            }else{
                let userLogin = userLogin(email: email, password: password)
                NetworkingProvider.shared.login(user: userLogin) { User in

                    if let user_token = User?.token {
                        UserDefaults.standard.set(user_token, forKey: "token")
                        self.performSegue(withIdentifier: "readySegue", sender: Any?.self)
                    }

                } failure: { error in
                    print(error)
                }
            }
            
            
            
        }
    }
    
    
    /*
     Método de Registro
     */
    @IBOutlet weak var addEmail: UITextField!
    @IBOutlet weak var addPass: UITextField!
    @IBOutlet weak var addRepeatPass: UITextField!
    @IBOutlet weak var addJob: UITextField!
    @IBOutlet weak var addSalary: UITextField!
    @IBOutlet weak var addBio: UITextField!
    @IBOutlet weak var addName: UITextField!
    
    var name:String?
    var job: String?
    var salary: Int?
    var biography: String?
    
    @IBAction func addUserBt(_ sender: UIButton) {
        name = addName.text
        email = addEmail.text
        password = addPass.text
        job = addJob.text
        salary = Int(addSalary.text!)
        biography = addBio.text
        
        if let name = name,let email = email, let password = password, let job = job, let salary = salary, let bio = biography   {
            let addUser = AddUser( name: name, email: email, password: password, Workstation: job, salary: salary, biography: bio, created_at: nil, updated_at: nil)
            
            let api_token = UserDefaults.standard.string(forKey: "token")
            
            NetworkingProvider.shared.addUser(user: addUser, api_token: api_token!) { user in
                //                print(user)
            } failure: { error in
                print(error)
            }
        }
    }
    
    /*
     Método de recuperar contraseña
     */
    
    @IBOutlet weak var emailRecover: UITextField!
    
    var recoveryEmail:String?
    
    @IBAction func recoverPassBt(_ sender: UIButton) {
        
        recoveryEmail = emailRecover.text
        
        if let email = recoveryEmail {
            NetworkingProvider.shared.recoveryPass(email: email){ user in
                print("Se ha enviado su nueva contraseña.")
            }failure: { error in
                print(error)
            }
        }
        
    }
    
    
    
    
    
    func readyScreen(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "readySegue" {
            if((segue.destination as? listViewController) != nil){
                
            }
        }
    }
    
    
}

extension UIViewController {

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

