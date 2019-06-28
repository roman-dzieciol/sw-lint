
import Foundation
import SwiftSyntax

open class SWSyntaxPrinter<T: TextOutputStream>: SyntaxRewriter {

    let indent = SWIndentContext()

    var output: T!

    public override init() {
        super.init()
    }

    open func write(_ node: Syntax, to output: inout T) {
        self.output = output
        let _ = visit(node)
        output = self.output
    }


    open override func visitPre(_ node: Syntax) {

        if let token = node as? TokenSyntax {

            if case let .identifier(name) = token.tokenKind {

                output.write("\n\(indent.text)-- \(name)")
            }

        } else {
            output.write("\n\(indent.text)\(type(of: node))")
            indent.level += 1
        }
        super.visitPre(node)
    }

    open override func visitPost(_ node: Syntax) {

        if let _ = node as? TokenSyntax {

        } else {
            indent.level -= 1
        }
        super.visitPost(node)
    }



}
