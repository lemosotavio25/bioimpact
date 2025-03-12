import UIKit


class HomeViewController: UIViewController {
    var userName: String = "José"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Olá, \(userName)!"
    }

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func carImpactTapped(_ sender: UIButton) {
        print("🚗 Impacto do carro selecionado")
    }

    @IBAction func energyImpactTapped(_ sender: UIButton) {
        print("⚡ Impacto de energia selecionado")
    }

    @IBAction func statsTapped(_ sender: UIButton) {
        print("📊 Estatísticas selecionadas")
    }

    @IBAction func tipsTapped(_ sender: UIButton) {
        print("🌱 Dicas Sustentáveis selecionadas")
    }
}
