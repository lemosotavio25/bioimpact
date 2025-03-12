import UIKit

class ProdutosTableViewController: UITableViewController {
    
    var produtosConsumidos: [[String: String]] = [] // Lista de produtos consumidos (Nome + Embalagem)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Produtos Consumidos"
        
        // Adicionar botão "+" para adicionar produto
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(abrirTelaAdicionar))
        
        carregarProdutos() // 🔹 Carregar produtos salvos ao abrir a tela
    }
    
    @objc func abrirTelaAdicionar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let adicionarVC = storyboard.instantiateViewController(withIdentifier: "AdicionarProdutoViewController") as? AdicionarProdutoViewController {
            adicionarVC.delegate = self
            present(adicionarVC, animated: true, completion: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtosConsumidos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProdutoCell", for: indexPath) ?? UITableViewCell(style: .default, reuseIdentifier: "ProdutoCell")

        let produto = produtosConsumidos[indexPath.row] // Obtém o dicionário
        cell.textLabel?.text = produto["nome"] ?? "Produto Desconhecido" // 🔹 Exibe apenas o nome
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        return cell
    }
    
    // 🔹 Função para salvar no UserDefaults
    func salvarProdutos() {
        let defaults = UserDefaults.standard
        
        // 🔹 Só salva se houver produtos na lista
        if !produtosConsumidos.isEmpty {
            defaults.set(produtosConsumidos, forKey: "produtosSalvos")
            print("✅ Produtos salvos no UserDefaults:", produtosConsumidos) // Debug
        } else {
            print("⚠️ Lista de produtos vazia! Nada foi salvo.") // Debug
        }
    }
    
    // 🔹 Função para carregar do UserDefaults
    func carregarProdutos() {
        let defaults = UserDefaults.standard

        // Verifica se há produtos salvos
        if let produtosSalvos = defaults.array(forKey: "produtosSalvos") as? [[String: String]], !produtosSalvos.isEmpty {
            produtosConsumidos = produtosSalvos
            print("✅ Produtos carregados do UserDefaults:", produtosConsumidos) // Debug
        } else {
            print("🔹 Nenhum produto encontrado no UserDefaults, carregando produtos mockados.") // Debug
            
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

            salvarProdutos() // 🔹 Salva os produtos mockados para garantir persistência
        }
    }
}

// 🔹 Extensão para receber produtos do formulário de adição
extension ProdutosTableViewController: AdicionarProdutoDelegate {
    func adicionarProduto(_ produto: [String: String]) { // 🔹 Agora aceita um dicionário
        produtosConsumidos.append(produto) // Adiciona nome + embalagem à lista
        tableView.reloadData()
        salvarProdutos() // 🔹 Salvar os produtos após adicionar um novo item
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 🔹 Remove o produto da lista
            produtosConsumidos.remove(at: indexPath.row)
            
            // 🔹 Atualiza os dados no UserDefaults
            salvarProdutos()
            
            // 🔹 Remove a célula da tabela
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Atualizar método para exibir os detalhes corretos
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detalhesVC = storyboard.instantiateViewController(withIdentifier: "ProdutoDetalhesViewController") as? ProdutoDetalhesViewController {

            // Passa os detalhes para a tela de detalhes
            detalhesVC.produto = produtosConsumidos[indexPath.row]
            
            navigationController?.pushViewController(detalhesVC, animated: true)
        }
    }
}
