import SwiftUI

struct MealScheduleView: View {

    let meals: [ChildMeal]

    var body: some View {

        GlassCardView {

            VStack(alignment: .leading, spacing: 16) {

                Text("Meal Schedule")
                    .font(.title2.bold())

                ForEach(meals) { meal in

                    VStack(alignment: .leading, spacing: 6) {

                        Text(meal.mealType.title)
                            .font(.headline)

                        Text(meal.foodDescription)

                        StatusBadgeView(
                            title: meal.portionConsumed.title,
                            color: .green
                        )
                    }

                    Divider()
                }
            }
        }
    }
}
