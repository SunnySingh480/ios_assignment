import Foundation

// Define models for the API response

// Model for fetching list of meals
struct MealResponse: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String { idMeal }
}

// Model for fetching meal details
struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let ingredients: [String]

    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredients = "strIngredient"
        case strMeasures = "strMeasure"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        var ingredients = [String]()
        for i in 1...20 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(i)")!
            
            let ingredient = try? container.decode(String.self, forKey: ingredientKey)
            let measure = try? container.decode(String.self, forKey: measureKey) ?? ""
            
            if let ingredient = ingredient, !ingredient.isEmpty {
                ingredients.append("\(ingredient): \(measure)")
            }
        }
        self.ingredients = ingredients
    }
}
