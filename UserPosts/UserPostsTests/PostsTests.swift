import XCTest
@testable import UserPosts

class PostsTests: XCTestCase {
    let connection: Connection = MockedConnection(fileName: "postsData")
    let handler: PostsHandler = MockedPostsController()
    var mockedPost: Post?
    
    override func setUp() {
        super.setUp()
        setupValidPost()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func setupValidPost() {
        let path = Bundle(for: PostsTests.self).path(forResource: "validPostData", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let json = try! JSONSerialization.jsonObject(with: data as Data, options: []) as! Dictionary<String, Any>
        let post = Post(json: json)
        self.mockedPost = post
    }
    
    func testConnection() {
        connection.fetchPosts(forUser: 2) { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.value)
            XCTAssertNil(result.error)
            XCTAssertTrue(result.value!.count > 0, "result must not be empty")
        }
    }
    
    func testHandler() {
        handler.fetchPosts(forUser: 2) { post in
            XCTAssertNotNil(post)
            XCTAssertNotNil(post.value)
            XCTAssertNotNil(post.value?.first)
        }
    }
    
    func testPostModel() {
        let post = mockedPost
        
        XCTAssertNotNil(post)
        XCTAssertEqual(post!.id, 11)
        XCTAssertEqual(post!.userId, 2)
        XCTAssertEqual(post!.title, "et ea vero quia laudantium autem")
        XCTAssertEqual(post!.body, "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\naccusamus in eum beatae sit\nvel qui neque voluptates ut commodi qui incidunt\nut animi commodi")
    }
    
    func testInvalidPostModel() {
        let path = Bundle(for: PostsTests.self).path(forResource: "invalidPostData", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let json = try! JSONSerialization.jsonObject(with: data as Data, options: []) as! Dictionary<String, Any>
        let post = Post(json: json)
        
        XCTAssertNil(post)
    }
    
}
