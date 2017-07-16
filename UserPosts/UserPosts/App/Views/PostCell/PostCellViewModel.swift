import Foundation

class PostCellViewModel: PostCellRepresentable {
    var title: String
    var body: String
    
    init(post: Post) {
        title = post.title
        body = post.body
    }
}
