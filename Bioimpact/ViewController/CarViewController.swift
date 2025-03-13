import UIKit

class CarViewController: UIViewController {
    
    @IBOutlet weak var Calcular: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var InsiraDistancia: UITextField!
    @IBOutlet weak var Frequencia: UISegmentedControl!
    
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

        // 📌 Definir multiplicador de acordo com a frequência
        let frequenciaSelecionada = Frequencia.selectedSegmentIndex
        let multiplicador: Double
        
        switch frequenciaSelecionada {
        case 0: // Semanal
            multiplicador = 7
        case 1: // Mensal
            multiplicador = 20
        case 2: // Único
            multiplicador = 1
        default:
            multiplicador = 1
        }

        let distanciaTotal = distance * multiplicador
        print("📤 Enviando requisição para API com distância total: \(distanciaTotal) km")

        apiService.fetchCarbonEstimate(distance: distanciaTotal) { result in
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
