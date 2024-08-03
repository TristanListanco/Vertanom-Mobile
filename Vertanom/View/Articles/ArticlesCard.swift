import SwiftUI

struct ArticlesCardView: View {
    let article: Article
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var namespace: Namespace.ID

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "book.pages")
                .foregroundStyle(.accent)
            Text(article.title)
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
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
