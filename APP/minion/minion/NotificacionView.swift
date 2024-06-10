//
//  NotificacionView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct NotificacionView: View {
    @State private var posts: [APIPost] = []
    @State private var images: [Int: Image] = [:]
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Notificaciones")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding()

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(posts) { post in
                            NavigationLink(destination: NotaView(title: post.titulo, image: images[post.id], message: post.contenido, date: post.fecha, author: post.autor).navigationBarTitle("", displayMode: .inline)) {
                                NotificationCard(
                                    title: post.titulo,
                                    image: images[post.id],
                                    message: post.contenido,
                                    date: post.fecha,
                                    author: post.autor
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
            .onAppear {
                fetchPosts()
            }
        }
    }

    private func fetchPosts() {
        APIService.shared.fetchAllPosts { result in
            switch result {
            case .success(let posts):
                self.posts = posts
                for post in posts {
                    fetchImage(for: post)
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchImage(for post: APIPost) {
        APIService.shared.fetchPostImage(postId: post.id_post) { result in
            switch result {
            case .success(let data):
                if let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)
                    self.images[post.id_post] = image
                }
            case .failure(let error):
                print("Failed to fetch image for post \(post.id_post): \(error.localizedDescription)")
            }
        }
    }
}

struct NotificationCard: View {
    var title: String
    var image: Image?
    var message: String
    var date: String
    var author: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .lineLimit(nil)
                .foregroundColor(.black)
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            }
            HStack {
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text("•")
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(author)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.black)
            }
            Text(message)
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct NotificacionView_Previews: PreviewProvider {
    static var previews: some View {
        NotificacionView()
    }
}
