import Foundation

class CarbonAPIService {
    let baseURL = "https://www.carboninterface.com/api/v1/estimates"
    let apiKey = "KgA3RyVCGYdOwFzFYI3w" 

    func fetchCarbonEstimate(distance: Double, completion: @escaping (Result<Double, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "URL Inválida", code: 400)))
            return
        }

        // Criamos a requisição com o novo valor de distância
        let requestData = CarbonRequest(type: "vehicle", distanceUnit: "km", distanceValue: distance, vehicleModelId: "7268a9b7-17e8-4c8d-acca-57059252afe9")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization") // Autenticação

        do {
            let jsonData = try JSONEncoder().encode(requestData)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Nenhum dado retornado", code: 500)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(CarbonResponse.self, from: data)
                let carbonKg = decodedResponse.data.attributes.carbonKg
                completion(.success(carbonKg)) // Retorna o valor de CO₂ calculado
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
