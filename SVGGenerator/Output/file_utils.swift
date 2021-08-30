
import Foundation



func write(_ content: String, to url: URL) {

    try! content.data(using: .utf8)!.write(to: url)
    
    print("written to \(url)")
}
