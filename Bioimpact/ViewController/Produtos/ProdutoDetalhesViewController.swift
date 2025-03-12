import UIKit

class ProdutoDetalhesViewController: UIViewController {

    var produto: [String: String]? // Recebe os detalhes do produto

    @IBOutlet weak var nomeProdutoLabel: UILabel!
    @IBOutlet weak var embalagemLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let produto = produto {
            nomeProdutoLabel.text = produto["nome"]
            embalagemLabel.text = "Embalagem: \(produto["embalagem"] ?? "Não especificado")"
        }
    }
}
