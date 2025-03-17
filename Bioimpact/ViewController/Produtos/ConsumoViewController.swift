import UIKit

class ConsumoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var co2TotalLabel: UILabel!
    @IBOutlet weak var embalagensTotalLabel: UILabel!
    @IBOutlet weak var comprovanteImageView: UIImageView! // Exibir a imagem do comprovante
    



    var produtosConsumidos: [[String: String]] = [] // Lista de produtos consumidos (Nome + Embalagem)

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
        
        comprovanteImageView.image = UIImage(named: "cumpom_fiscal")
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

    // 🔹 Função para adicionar um comprovante (tirar foto ou escolher da galeria)
    @IBAction func addComprovante(_ sender: UIButton) {
        let alert = UIAlertController(title: "Adicionar Comprovante", message: "De onde você quer pegar o comprovante?", preferredStyle: .actionSheet)

        // 📸 Opção: Tirar foto com a câmera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (_) in
                self.abrirImagePicker(tipo: .camera)
            }
            alert.addAction(cameraAction)
        }

        // 🖼️ Opção: Escolher da galeria
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let galeriaAction = UIAlertAction(title: "Galeria", style: .default) { (_) in
                self.abrirImagePicker(tipo: .photoLibrary)
            }
            alert.addAction(galeriaAction)
        }

        // ❌ Opção: Cancelar
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelarAction)

        present(alert, animated: true, completion: nil)
    }

    // 🔹 Função para abrir o ImagePicker (Câmera ou Galeria)
    func abrirImagePicker(tipo: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = tipo
        picker.allowsEditing = true // Permite edição da imagem
        present(picker, animated: true, completion: nil)
    }

    // 🔹 Captura da imagem escolhida
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagemEscolhida = info[.editedImage] as? UIImage {
            comprovanteImageView.image = imagemEscolhida
        } else if let originalImage = info[.originalImage] as? UIImage {
            comprovanteImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }

    // 🔹 Cancelamento do ImagePicker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
