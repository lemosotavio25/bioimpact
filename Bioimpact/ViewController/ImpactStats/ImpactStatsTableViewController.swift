import UIKit

class ImpactStatsTableViewController: UITableViewController {

    let impactoDados: [ImpactoConsumo] = [
        ImpactoConsumo(periodo: "Semanal", impactoCO2: 150.0, impactoCO2Anterior: 180.0, mediaCO2: 320.0,
                       detalhes: [
                           ("01/03/2025", 30.0),
                           ("02/03/2025", 20.0),
                           ("03/03/2025", 25.0),
                           ("04/03/2025", 22.0),
                           ("05/03/2025", 18.0),
                           ("06/03/2025", 20.0),
                           ("07/03/2025", 15.0)
                       ]),
        ImpactoConsumo(periodo: "Mensal", impactoCO2: 600.0, impactoCO2Anterior: 550.0, mediaCO2: 1250.0,
                       detalhes: [
                           ("Semana 1", 150.0),
                           ("Semana 2", 140.0),
                           ("Semana 3", 160.0),
                           ("Semana 4", 150.0)
                       ]),
        ImpactoConsumo(periodo: "Anual", impactoCO2: 7200.0, impactoCO2Anterior: 7300.0, mediaCO2: 15000.0,
                       detalhes: [
                           ("Janeiro", 600.0),
                           ("Fevereiro", 580.0),
                           ("Março", 610.0),
                           ("Abril", 590.0),
                           ("Maio", 620.0),
                           ("Junho", 610.0),
                           ("Julho", 605.0),
                           ("Agosto", 630.0),
                           ("Setembro", 620.0),
                           ("Outubro", 600.0),
                           ("Novembro", 610.0),
                           ("Dezembro", 620.0)
                       ])
    ]

    var periodoSelecionado = 0 // 0 = Semana, 1 = Mês, 2 = Ano

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Impacto Ambiental"

        // Criar Segmented Control
        let segmentedControl = UISegmentedControl(items: ["Semana", "Mês", "Ano"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mudarPeriodo(_:)), for: .valueChanged)

        // Adicionar à barra de navegação
        navigationItem.titleView = segmentedControl

        // Configurar espaço entre o cabeçalho e a tabela
        atualizarHeader()

        // Remover linhas vazias no final da tabela
        tableView.tableFooterView = UIView()
    }

    @objc func mudarPeriodo(_ sender: UISegmentedControl) {
        periodoSelecionado = sender.selectedSegmentIndex
        atualizarHeader()
        tableView.reloadData()
    }

    func atualizarHeader() {
        let impactoAtual = impactoDados[periodoSelecionado]
        let diferenca = impactoAtual.impactoCO2 - impactoAtual.impactoCO2Anterior

        var indicador = "➖ Estável"
        if diferenca < 0 {
            indicador = "📉 Redução de \(abs(diferenca)) kg CO₂"
        } else if diferenca > 0 {
            indicador = "📈 Aumento de \(diferenca) kg CO₂"
        }

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        headerView.backgroundColor = UIColor.systemGroupedBackground

        let label = UILabel(frame: CGRect(x: 0, y: 10, width: headerView.frame.width, height: 90))
        label.text = """
            🌍 Impacto \(impactoAtual.periodo): CO₂ = \(impactoAtual.impactoCO2) kg, Média = \(impactoAtual.mediaCO2) kg
            \(indicador)
        """
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        headerView.addSubview(label)
        tableView.tableHeaderView = headerView
    }

    // Número de seções
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Número de linhas na tabela
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return impactoDados[periodoSelecionado].detalhes.count
    }

    // Configuração das células
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImpactCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "ImpactCell")

        let impactoAtual = impactoDados[periodoSelecionado]
        let dado = impactoAtual.detalhes[indexPath.row]

        // Centralizar os textos
        cell.textLabel?.text = dado.0 // Nome do período (Data/Semana/Mês)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        cell.detailTextLabel?.text = "CO₂: \(dado.1) kg" // Impacto de CO₂
        cell.detailTextLabel?.textAlignment = .center
        cell.detailTextLabel?.textColor = .darkGray
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        return cell
    }

    // Ajustar altura das células para melhor visualização
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    // Adicionar espaçamento entre o cabeçalho e a primeira célula
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15 // Espaço antes da primeira célula
    }
}
