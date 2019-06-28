
import Foundation
import SwiftSyntax
import SwiftSyntaxUtil


open class SWFormatter: SyntaxRewriter {

    var level = 0
    var spaces = 4
    var indentSpaces: Int { level * spaces }

    var previousToken: TokenSyntax?
    var syntaxToNewline: Syntax?
    var syntaxNewlineNum = 0
    var closingTokens: [TokenSyntax] = []

    public override init() {
        super.init()
    }

    func withIndent<U>(_ action: () -> U) -> U {
        level = level + 1
        defer {
            level = level - 1
        }
        return action()
    }

    func withNewline<U>(_ action: () -> U) -> U {
        level = level + 1
        defer {
            level = level - 1
        }
        return action()
    }


    override open func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
        syntaxToNewline = node
        syntaxNewlineNum += 2
        return super.visit(node)
    }

    override open func visit(_ node: EnumCaseDeclSyntax) -> DeclSyntax {
        syntaxToNewline = node
        syntaxNewlineNum += 1
        return super.visit(node)
    }

    override open func visit(_ node: ExtensionDeclSyntax) -> DeclSyntax {
        syntaxToNewline = node
        syntaxNewlineNum += 1
        return super.visit(node)
    }

    override open func visit(_ node: InitializerDeclSyntax) -> DeclSyntax {
        syntaxToNewline = node
        syntaxNewlineNum += 2
        return super.visit(node)
    }

    override open func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        syntaxToNewline = node
        syntaxNewlineNum += 2
        return super.visit(node)
    }

    override open func visit(_ node: FunctionParameterSyntax) -> Syntax {
        if node.has(ancestorType: InitializerDeclSyntax.self) {
            syntaxToNewline = node
            syntaxNewlineNum += 1
            return super.visit(node)
        } else {
            return super.visit(node)
        }
    }

    override open func visit(_ node: ParameterClauseSyntax) -> Syntax {
        if node.has(ancestorType: InitializerDeclSyntax.self) {
            return withIndent { super.visit(node) }
        } else {
            return super.visit(node)
        }
    }

    override open func visit(_ node: StructDeclSyntax) -> DeclSyntax {
        syntaxToNewline = node
        syntaxNewlineNum += 2
        return super.visit(node)
    }

    override open func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        syntaxToNewline = node
        syntaxNewlineNum = 1
        return super.visit(node)
    }

    override open func visit(_ node: ClassDeclSyntax) -> DeclSyntax {
        syntaxToNewline = node
        syntaxNewlineNum += 2
        return super.visit(node)
    }

    override open func visit(_ node: MemberDeclBlockSyntax) -> Syntax {
        return withIndent { super.visit(node) }
    }

    //    override open func visit(_ node: MemberDeclListSyntax) -> Syntax {
    //        if node.has(ancestorTypes: [MemberDeclBlockSyntax.self, ClassDeclSyntax.self]) {
    ////            syntaxToNewline = node
    ////            syntaxNewlineNum += 1
    //        }
    //        return super.visit(node)
    //    }

    override open func visit(_ node: CodeBlockSyntax) -> Syntax {
        return withIndent { super.visit(node) }
    }

    override open func visit(_ node: CodeBlockItemSyntax) -> Syntax {
        syntaxToNewline = node
        syntaxNewlineNum += 1
        return super.visit(node)
    }

    override open func visit(_ token: TokenSyntax) -> Syntax {
        var t = token

        if t.isMissing {
            return super.visit(token)
        }

        var leadingSpace = false
        var leadingNewline = 0

        if let syntaxToNewline = syntaxToNewline, t.has(ancestor: syntaxToNewline) {
            leadingNewline = syntaxNewlineNum


            self.syntaxToNewline = nil
            syntaxNewlineNum = 0
        }

        switch t.tokenKind {
        case .rightParen:
            if t.has(ancestorType: InitializerDeclSyntax.self) && t.has(ancestorType: ParameterClauseSyntax.self) {
                leadingNewline = 1
            }
        default:
            break
        }


        switch t.tokenKind {
        case .rightBrace:
            leadingNewline = 1
        default:
            break
        }

        switch t.tokenKind {
        case
        .comma,
        .period,
        .colon,
        .leftSquareBracket,
        .rightSquareBracket,
        //.leftBrace,
        .rightBrace,
        .leftAngle,
        .rightAngle,
        .leftParen,
        .rightParen,
        .postfixQuestionMark:
            break
        default:
            leadingSpace = true
        }

        if let previousToken = previousToken {
            switch previousToken.tokenKind {
            case
            .colon:
                leadingSpace = true
            default:
                break
            }
            switch previousToken.tokenKind {
            case
            .period,
            .prefixPeriod,
            .leftParen,
            .leftAngle,
            .leftBrace,
            .leftSquareBracket:
                leadingSpace = false
            default:
                break
            }
        }

        if leadingNewline > 0 {
            t = t.withLeadingTrivia(t.leadingTrivia.appending(.newlines(leadingNewline)))
        }

        if leadingNewline > 0 {
            if t.tokenKind == .rightBrace {
                t = t.withLeadingTrivia(t.leadingTrivia.appending(.spaces(indentSpaces - spaces)))
            } else {
                t = t.withLeadingTrivia(t.leadingTrivia.appending(.spaces(indentSpaces)))
            }
        }

        if leadingSpace && leadingNewline == 0 {
            t = t.withLeadingTrivia(t.leadingTrivia.appending(.spaces(1)))
        }

        previousToken = t
        return super.visit(t)
    }

}



