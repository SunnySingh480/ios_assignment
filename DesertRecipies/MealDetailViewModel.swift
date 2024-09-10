import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    private let networkManager = NetworkManager()
    
    func fetchMealDetail(id: String) async {
        do {
            mealDetail = try await networkManager.fetchMealDetail(id: id)
        } catch {
            print("Failed to fetch meal detail: \(error.localizedDescription)")
        }
    }
}
