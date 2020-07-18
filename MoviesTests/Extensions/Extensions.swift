import Foundation
import XCTest
import SnapshotTesting

//MARK- Decodable
extension Decodable {
    static func fromJSON<T: Decodable>(bundle: Bundle, filename: String, type: String = "json") -> T? {
        guard let path = bundle.path(forResource: filename, ofType: type),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return nil }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

/*
 Little add-on to SnapshotTesting to record snapshot tests
 for all available devices in one time.
 */
extension XCTest {
    func verifyViewOnAllDevices(orientation: ViewImageConfig.Orientation = .portrait,
                                file: StaticString = #file,
                                testName: String = #function,
                                _ view: @escaping () -> UIViewController) {
        [ViewImageConfig.iPhoneSe(orientation),
         ViewImageConfig.iPhone8(orientation),
         ViewImageConfig.iPhone8Plus(orientation),
         ViewImageConfig.iPhoneX(orientation),
         ViewImageConfig.iPhoneXsMax(orientation),
         ViewImageConfig.iPhoneXr(orientation)
            ].forEach { size in
                assertSnapshot(matching: view(), as: .image(on: size), record: record, file: file, testName: testName)
        }
    }
}
