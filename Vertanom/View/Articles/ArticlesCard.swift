import SwiftUI

struct ArticlesCardView: View {
    let article: Article
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var namespace: Namespace.ID

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(article.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(Color.primary)

                Text(article.content)
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(Color.secondary)
                    .truncationMode(.tail)
            }
            .padding([.horizontal, .bottom])
        }
        .background(Rectangle()
        )
        .foregroundColor(backgroundColor)
        .cornerRadius(15)
        .frame(maxWidth: .infinity)
        .frame(minHeight: 170) // Ensure a minimum height but allow it to grow
    }
}

// Computed property to determine the background color based on the platform
private var backgroundColor: Color {
    #if os(iOS) || os(tvOS)
    return Color(.secondarySystemBackground)
    #elseif os(macOS)
    return Color(NSColor.windowBackgroundColor)
    #endif
}

struct ArticlesCardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleArticle = Article(
            id: UUID(),
            imageName: "article-1",
            title: "The Future of IoT in Agriculture",
            content: "The integration of IoT in agriculture has"
        )
        @Namespace var namespace
        ArticlesCardView(article: sampleArticle, namespace: namespace)
    }
}
