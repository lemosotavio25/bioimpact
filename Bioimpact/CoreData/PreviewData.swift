//
//  PreviewData.swift
//  Bioimpact
//
//  Created by Otávio Conde Lemos on 01/03/25.
//


import CoreData

struct PreviewData {
    static let shared = PreviewData()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "UserModel") // Nome do seu .xcdatamodeld
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("❌ Erro ao carregar Core Data: \(error), \(error.userInfo)")
            }
        }
    }

    func adicionarDadosExemplo() {
        let context = container.viewContext
        let novoUsuario = User(context: context)
        novoUsuario.email = "teste@email.com"
        novoUsuario.password = "123456"

        do {
            try context.save()
            print("✅ Usuário de teste adicionado com sucesso!")
        } catch {
            print("❌ Erro ao salvar usuário: \(error.localizedDescription)")
        }
    }
}
