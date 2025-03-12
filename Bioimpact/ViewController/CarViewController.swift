import UIKit

class CarViewController: UIViewController {
    
    @IBOutlet weak var Calcular: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var InsiraDistancia: UITextField!
    
    let apiService = CarbonAPIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("✅ View carregada!") // Log para confirmar que a tela abriu
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        print("🔘 Botão calcular pressionado!") // Log para ver se o botão foi acionado
        
        guard let distanceText = InsiraDistancia.text, !distanceText.isEmpty, let distance = Double(distanceText) else {
            print("⚠️ Entrada inválida!")
            resultLabel.text = "Por favor, insira um valor válido."
            return
        }

        print("📤 Enviando requisição para API com distância: \(distance) km")

        apiService.fetchCarbonEstimate(distance: distance) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let carbonKg):
                    print("✅ Resposta recebida: \(carbonKg) kg de CO₂")
                    self.resultLabel.text = "🌍 Emissão de CO₂: \(carbonKg) kg"
                case .failure(let error):
                    print("❌ Erro ao calcular: \(error.localizedDescription)")
                    self.resultLabel.text = "Erro ao calcular: \(error.localizedDescription)"
                }
            }
        }
    }
}
