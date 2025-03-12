import UIKit

protocol AdicionarProdutoDelegate: AnyObject {
    func adicionarProduto(_ produto: [String: String])
}

class AdicionarProdutoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var embalagemPickerView: UIPickerView!

    weak var delegate: AdicionarProdutoDelegate?

    let tiposEmbalagem = ["Plástico", "Vidro", "Papel", "Alumínio", "Nenhuma"]
    var embalagemSelecionada: String = "Plástico"

    override func viewDidLoad() {
        super.viewDidLoad()
        embalagemPickerView.delegate = self
        embalagemPickerView.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiposEmbalagem.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiposEmbalagem[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        embalagemSelecionada = tiposEmbalagem[row]
    }

    @IBAction func adicionarProduto(_ sender: UIButton) {
        guard let nome = nomeTextField.text, !nome.isEmpty else {
            print("❌ Insira um nome válido")
            return
        }

        let novoProduto = ["nome": nome, "embalagem": embalagemSelecionada]
        delegate?.adicionarProduto(novoProduto)
        dismiss(animated: true, completion: nil)
    }
}
