import UIKit

class ConsumoViewController: UIViewController {

    @IBOutlet weak var co2TotalLabel: UILabel!
    @IBOutlet weak var embalagensTotalLabel: UILabel!

    var produtosConsumidos: [[String: String]] = [] // Recebe a lista de produtos

    let impactoCO2PorProduto: [String: Double] = [
        "Refrigerante": 0.8,
        "Café": 1.2,
        "Carne Bovina": 27.0,
        "Arroz": 2.5,
        "Leite": 3.2,
        "Pão": 1.0,
        "Cerveja": 2.3,
        "Chocolate": 4.5,
        "Queijo": 13.5,
        "Macarrão": 1.4
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // 🔹 Lista fixa de produtos para testes
        produtosConsumidos = [
            ["nome": "Refrigerante", "embalagem": "Plástico"],
            ["nome": "Café", "embalagem": "Nenhuma"],
            ["nome": "Carne Bovina", "embalagem": "Nenhuma"],
            ["nome": "Arroz", "embalagem": "Plástico"],
            ["nome": "Leite", "embalagem": "Vidro"],
            ["nome": "Pão", "embalagem": "Papel"],
            ["nome": "Cerveja", "embalagem": "Alumínio"],
            ["nome": "Chocolate", "embalagem": "Papel"],
            ["nome": "Queijo", "embalagem": "Plástico"],
            ["nome": "Macarrão", "embalagem": "Plástico"]
        ]
    }

    @IBAction func calcularImpacto(_ sender: UIButton) {
        var totalCO2: Double = 0.0
        var totalEmbalagens: Int = 0

        for produto in produtosConsumidos {
            let nome = produto["nome"] ?? ""

            // 🔹 Adiciona o impacto de CO₂ se o produto estiver na tabela
            if let impacto = impactoCO2PorProduto[nome] {
                totalCO2 += impacto
            }

            // 🔹 Conta quantos produtos têm embalagem
            if let embalagem = produto["embalagem"], embalagem != "Nenhuma" {
                totalEmbalagens += 1
            }
        }

        // 🔹 Atualiza os labels na tela
        co2TotalLabel.text = "🌍 Total de CO₂: \(totalCO2) kg"
        embalagensTotalLabel.text = "📦 Embalagens usadas: \(totalEmbalagens)"
    }
}
