import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DessertViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(meal.strMeal)
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                Task {
                    await viewModel.fetchDesserts()
                }
            }
        }
    }
}

class DessertViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private let networkManager = NetworkManager()
    
    func fetchDesserts() async {
        do {
            meals = try await networkManager.fetchDesserts()
        } catch {
            print("Failed to fetch desserts: \(error.localizedDescription)")
        }
    }
}
