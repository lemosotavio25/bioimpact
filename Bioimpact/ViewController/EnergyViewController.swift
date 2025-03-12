import UIKit

class EnergyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var billTextField: UITextField! // Campo para valor da conta de luz
    @IBOutlet weak var tariffPicker: UIPickerView! // PickerView para bandeira tarifária
    @IBOutlet weak var calculateButton: UIButton! // Botão de cálculo
    @IBOutlet weak var resultLabel: UILabel! // Resultado do cálculo
    
    let tariffs = ["Verde", "Amarela", "Vermelha"] // Opções da bandeira tarifária
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tariffPicker.delegate = self
        tariffPicker.dataSource = self
        resultLabel.text = "" // Esconde o resultado no início
    }
    
    // MARK: - PickerView DataSource & Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tariffs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tariffs[row]
    }
    
    // MARK: - Cálculo do Consumo de Energia
    
    @IBAction func calculateImpact(_ sender: UIButton) {
        guard let billText = billTextField.text, let billValue = Double(billText) else {
            resultLabel.text = "❌ Insira um valor válido!"
            return
        }
        
        let selectedTariff = tariffs[tariffPicker.selectedRow(inComponent: 0)]
        let costPerKWh: Double
        
        switch selectedTariff {
        case "Verde":
            costPerKWh = 0.70
        case "Amarela":
            costPerKWh = 0.75
        case "Vermelha":
            costPerKWh = 0.85
        default:
            costPerKWh = 0.70
        }
        
        let estimatedKWh = billValue / costPerKWh
        let emissionCO2 = estimatedKWh * 0.4 // Emissão de CO₂ por kWh
        
        resultLabel.text = """
        ⚡ Consumo estimado: \(Int(estimatedKWh)) kWh
        🌍 Emissão de CO₂: \(Int(emissionCO2)) kg
        """
    }
}
