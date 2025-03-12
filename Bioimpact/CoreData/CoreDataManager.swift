import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Verifica se o usuário existe no banco de dados para login
    func buscarUsuario(email: String, senha: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, senha)
        
        do {
            let resultado = try context.fetch(fetchRequest)
            return !resultado.isEmpty
        } catch {
            print("❌ Erro ao buscar usuário: \(error.localizedDescription)")
            return false
        }
    }
}
