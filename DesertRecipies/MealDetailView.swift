import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let meal = viewModel.mealDetail {
                Text(meal.strMeal)
                    .font(.largeTitle)
                    .padding()
                
                Text("Instructions:")
                    .font(.headline)
                    .padding(.top)
                
                Text(meal.strInstructions)
                    .padding()
                
                Text("Ingredients:")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(meal.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                .padding()
            } else {
                ProgressView()
                    .onAppear {
                        Task {
                            await viewModel.fetchMealDetail(id: mealID)
                        }
                    }
            }
        }
        .navigationTitle("Meal Detail")
    }
}
