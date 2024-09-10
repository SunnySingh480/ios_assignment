import Foundation

class NetworkManager {
    private let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    func fetchDesserts() async throws -> [Meal] {
        let url = URL(string: "\(baseURL)filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealResponse.self, from: data)
        return response.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    func fetchMealDetail(id: String) async throws -> MealDetail {
        let url = URL(string: "\(baseURL)lookup.php?i=\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        return response.meals.first!
    }
}
