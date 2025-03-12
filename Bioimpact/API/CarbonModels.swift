import Foundation

struct CarbonRequest: Codable {
    let type: String
    let distanceUnit: String
    var distanceValue: Double // Agora podemos alterar este valor
    let vehicleModelId: String

    enum CodingKeys: String, CodingKey {
        case type
        case distanceUnit = "distance_unit"
        case distanceValue = "distance_value"
        case vehicleModelId = "vehicle_model_id"
    }
}

struct CarbonResponse: Codable {
    let data: CarbonData
}

struct CarbonData: Codable {
    let id: String
    let type: String
    let attributes: CarbonAttributes
}

struct CarbonAttributes: Codable {
    let carbonKg: Double
    let distanceUnit: String
    let distanceValue: Double
    let vehicleModelId: String

    enum CodingKeys: String, CodingKey {
        case carbonKg = "carbon_kg"
        case distanceUnit = "distance_unit"
        case distanceValue = "distance_value"
        case vehicleModelId = "vehicle_model_id"
    }
}

