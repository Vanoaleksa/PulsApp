
import UIKit

struct DishModel {
    var mainImage: UIImage
    var dishName: String
    var kkal: String
    var cookingTime: String
    
    static func fetchBreakfastDishes() -> [DishModel] {
        let firstItem = DishModel(mainImage: UIImage(named: "Thin pancakes with milk - image")!,
                                  dishName: "Thin pancakes with milk ",
                                  kkal: "438 kkal",
                                  cookingTime: "15 min")
        
        let secondItem = DishModel(mainImage: UIImage(named: "Bacon and eggs  - image")!,
                                   dishName: "Bacon and eggs",
                                   kkal: "234 kkal",
                                   cookingTime: "15 min")
        
        let thirdItem = DishModel(mainImage: UIImage(named: "Avocado toast - image")!,
                                  dishName: "Avocado Toast",
                                  kkal: "130 kkal",
                                  cookingTime: "7 min")
        
        let fiveItem = DishModel(mainImage: UIImage(named: "Mac and cheese")!,
                                  dishName: "Mac and cheese",
                                  kkal: "130 kkal",
                                  cookingTime: "7 min")
        
        let sixItem = DishModel(mainImage: UIImage(named: "Toasts with jam and strawberry")!,
                                  dishName: "Toasts with jam and strawberry",
                                  kkal: "130 kkal",
                                  cookingTime: "7 min")
        
        let sevenItem = DishModel(mainImage: UIImage(named: "smoothie")!,
                                  dishName: "Smoothie",
                                  kkal: "130 kkal",
                                  cookingTime: "7 min")
        
        return [firstItem, secondItem, thirdItem, fiveItem, sixItem, sevenItem]
    }
    
    static func fetchLunchDishes() -> [DishModel] {
        let firstItem = DishModel(mainImage: UIImage(named: "Spicy soup")!,
                                  dishName: "Spicy coup ",
                                  kkal: "438 kkal",
                                  cookingTime: "15 min")
        
        let secondItem = DishModel(mainImage: UIImage(named: "Greek salat - image")!,
                                   dishName: "Greek salat",
                                   kkal: "234 kkal",
                                   cookingTime: "15 min")
        
        let thirdItem = DishModel(mainImage: UIImage(named: "Avocado feta wrap with corn")!,
                                  dishName: "Avocado feta wrap with corn",
                                  kkal: "130 kkal",
                                  cookingTime: "7 min")
        
        return [firstItem, secondItem, thirdItem]
    }
    
    static func fetchDinnerDishes() -> [DishModel] {
        let firstItem = DishModel(mainImage: UIImage(named: "Fish and vegetables")!,
                                  dishName: "Fish and vegetables",
                                  kkal: "438 kkal",
                                  cookingTime: "15 min")
        
        let secondItem = DishModel(mainImage: UIImage(named: "Spaghetti bolognese  - image")!,
                                   dishName: "Spaghetti bolognese ",
                                   kkal: "234 kkal",
                                   cookingTime: "15 min")
        
        let thirdItem = DishModel(mainImage: UIImage(named: "Fresh chicken roll")!,
                                  dishName: "Fresh chicken roll",
                                  kkal: "130 kkal",
                                  cookingTime: "7 min")
        
        return [firstItem, secondItem, thirdItem]
    }
}
