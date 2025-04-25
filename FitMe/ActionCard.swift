import SwiftUI

struct Action {
    let heading: String
    let subHeading: String
    let icon: String
    let value: String
    let goal: String
}

struct ActionCard: View {
    let action: Action  // Use `let` instead of `@State`
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
                .shadow(radius: 4)  // Add shadow for depth
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(action.heading)
                            .font(.system(size: 22, weight: .bold))  // Bold heading for emphasis
                        Text(action.subHeading)
                            .font(.caption)
                            .foregroundColor(.gray)  // Lighter color for subheading
                    }
                    Image(systemName: action.icon)
                        .font(.system(size: 35))
                        .padding()
                }
                
                Text(action.value)
                    .font(.system(size: 24, weight: .bold))  // Bold value for emphasis
                Text(action.goal)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)  // Lighter color for goal
            }
            .padding()
        }
        .padding(.horizontal)  // Add horizontal padding to the card
    }
}

struct ActionCard_Previews: PreviewProvider {
    static var previews: some View {
        ActionCard(action: Action(heading: "Steps", subHeading: "Today", icon: "figure.walk.motion", value: "5,000", goal: "Goal: 10,000"))
            .padding()  // Add padding to the preview for better visualization
            .previewLayout(.sizeThatFits)  // Fit to content size for the preview
    }
}
