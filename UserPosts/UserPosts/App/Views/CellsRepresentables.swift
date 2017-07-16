import Foundation

protocol UserCellRepresentable {
    var name: String { get }
    var userName: String { get }
    var email: String { get }
    var address: String { get }
}

protocol PostCellRepresentable {
    var title: String { get }
    var body: String { get }
}

protocol CellConfigurable: class {
    associatedtype CellViewModel
    var cellViewModel: CellViewModel? { get set }
}
