import XCTest
@testable import UserPosts

class UsersTests: XCTestCase {
    let connection: Connection = MockedConnection(fileName: "usersData")
    let handler: UsersHandler = MockedUsersController()
    var mockedUser: User?
    
    override func setUp() {
        super.setUp()
        setupValidUser()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func setupValidUser() {
        let path = Bundle(for: PostsTests.self).path(forResource: "validUserData", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let json = try! JSONSerialization.jsonObject(with: data as Data, options: []) as! Dictionary<String, Any>
        let user = User(json: json)
        self.mockedUser = user
    }
    
    func testConnection() {
        connection.fetchUsers { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.value)
            XCTAssertNil(result.error)
            XCTAssertTrue(result.value!.count > 0, "result must not be empty")
        }
    }
    
    func testHandler() {
        handler.fetchUsers { user in
            XCTAssertNotNil(user)
            XCTAssertNotNil(user.value)
            XCTAssertNotNil(user.value?.first)
        }
    }
    
    func testUserModel() {
        let user = mockedUser
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user!.id, 1)
        XCTAssertEqual(user!.name, "Leanne Graham")
        XCTAssertEqual(user!.username, "Bret")
        XCTAssertEqual(user!.email, "Sincere@april.biz")
        XCTAssertNotNil(user!.address)
        XCTAssertEqual(user?.address.street, "Kulas Light")
        XCTAssertEqual(user?.address.suite, "Apt. 556")
        XCTAssertEqual(user?.address.city, "Gwenborough")
        XCTAssertEqual(user?.address.zipcode, "92998-3874")
        XCTAssertNotNil(user!.address.location)
        XCTAssertEqual(user?.address.location.latitude, -37.3159)
        XCTAssertEqual(user?.address.location.longitude, 81.1496)
    }
    
    func testInvalidUserModel() {
        let path = Bundle(for: UsersTests.self).path(forResource: "invalidUserData", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        let json = try! JSONSerialization.jsonObject(with: data as Data, options: []) as! Dictionary<String, Any>
        let user = User(json: json)
        
        XCTAssertNil(user)
    }
    
    func testUserAddressDescription() {
        let user = mockedUser!
        
        let expectedAddressDescription = "Apt. 556, Kulas Light, Gwenborough, 92998-3874"
        XCTAssertNotNil(user.address.description)
        XCTAssertFalse(user.address.description.isEmpty, "description must not be empty")
        XCTAssertEqual(user.address.description, expectedAddressDescription)
    }
    
}
