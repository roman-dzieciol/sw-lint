
import Foundation

public class SWIndentContext {

    public var level = 0
    public var spaces = 4
    public var indentSpaces: Int { level * spaces }
    public var text: String { return String(repeating: " ", count: indentSpaces) }

    public init() {
    }

    public func indent<T>(_ action: () throws -> T) rethrows -> T  {
        level += 1
        let result = try action()
        level -= 1
        return result
    }
}
