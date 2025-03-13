import UIKit


class HomeViewController: UIViewController {
    var userName: String = "José"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Olá, \(userName)!"
    }

    @IBOutlet weak var titleLabel: UILabel!
    
}
