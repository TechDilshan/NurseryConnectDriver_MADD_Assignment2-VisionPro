import SwiftUI

struct MealCard: View {
    @EnvironmentObject var parentDashboardViewModel: ParentDashboardViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: "fork.knife")
                    .font(.system(size: 42))
                    .foregroundStyle(.purple)

                Spacer()

                Text("Meal Records")
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.purple.opacity(0.15))
                    .foregroundStyle(.purple)
                    .clipShape(Capsule())
            }

            Text("Today’s Meals")
                .font(.title2.bold())

            ForEach(parentDashboardViewModel.latestMeals) { meal in
                VStack(alignment: .leading, spacing: 4) {
                    Text(meal.mealType.title)
                        .font(.headline)

                    Text(meal.foodDescription)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("Portion: \(meal.portionConsumed.title)")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }

                Divider()
            }
        }
        .padding(24)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
