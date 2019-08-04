import XCTest
import SwiftSyntax
@testable import SWLintKit

final class SWSyntaxPrinterTests: XCTestCase {
    func testItPrints() throws {
        let source = """
import Foundation

public extension V3_19 {

    class ActionTestMetadata: ActionTestSummaryIdentifiableObject {
        public let testStatus: String

        private enum CodingKeys: CodingKey {
            case testStatus
        }

        public init(
            name: String?,
            identifier: String?,
            testStatus: String
            ) {
            self.testStatus = testStatus
            super.init(name: name, identifier: identifier)
        }

        public required init(
            from decoder: Decoder
            ) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            testStatus = try container.decode(String.self, forKey: .testStatus)
            try super.init(from: decoder)
        }

        public override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(testStatus, forKey: .testStatus)
        }
    }
}
"""
        
let syntax = """

SourceFileSyntax
    CodeBlockItemListSyntax
        CodeBlockItemSyntax
            ImportDeclSyntax, importKeyword
                AccessPathSyntax
                    AccessPathComponentSyntax, identifier("Foundation")
        CodeBlockItemSyntax
            ExtensionDeclSyntax
                ModifierListSyntax
                    DeclModifierSyntax, publicKeyword, extensionKeyword
                SimpleTypeIdentifierSyntax, identifier("V3_19")
                MemberDeclBlockSyntax, leftBrace
                    MemberDeclListSyntax
                        MemberDeclListItemSyntax
                            ClassDeclSyntax, classKeyword, identifier("ActionTestMetadata")
                                TypeInheritanceClauseSyntax, colon
                                    InheritedTypeListSyntax
                                        InheritedTypeSyntax
                                            SimpleTypeIdentifierSyntax, identifier("ActionTestSummaryIdentifiableObject")
                                MemberDeclBlockSyntax, leftBrace
                                    MemberDeclListSyntax
                                        MemberDeclListItemSyntax
                                            VariableDeclSyntax
                                                ModifierListSyntax
                                                    DeclModifierSyntax, publicKeyword, letKeyword
                                                PatternBindingListSyntax
                                                    PatternBindingSyntax
                                                        IdentifierPatternSyntax, identifier("testStatus")
                                                        TypeAnnotationSyntax, colon
                                                            SimpleTypeIdentifierSyntax, identifier("String")
                                        MemberDeclListItemSyntax
                                            EnumDeclSyntax
                                                ModifierListSyntax
                                                    DeclModifierSyntax, privateKeyword, enumKeyword, identifier("CodingKeys")
                                                TypeInheritanceClauseSyntax, colon
                                                    InheritedTypeListSyntax
                                                        InheritedTypeSyntax
                                                            SimpleTypeIdentifierSyntax, identifier("CodingKey")
                                                MemberDeclBlockSyntax, leftBrace
                                                    MemberDeclListSyntax
                                                        MemberDeclListItemSyntax
                                                            EnumCaseDeclSyntax, caseKeyword
                                                                EnumCaseElementListSyntax
                                                                    EnumCaseElementSyntax, identifier("testStatus"), rightBrace
                                        MemberDeclListItemSyntax
                                            InitializerDeclSyntax
                                                ModifierListSyntax
                                                    DeclModifierSyntax, publicKeyword, initKeyword
                                                ParameterClauseSyntax, leftParen
                                                    FunctionParameterListSyntax
                                                        FunctionParameterSyntax, identifier("name"), colon
                                                            OptionalTypeSyntax
                                                                SimpleTypeIdentifierSyntax, identifier("String"), postfixQuestionMark, comma
                                                        FunctionParameterSyntax, identifier("identifier"), colon
                                                            OptionalTypeSyntax
                                                                SimpleTypeIdentifierSyntax, identifier("String"), postfixQuestionMark, comma
                                                        FunctionParameterSyntax, identifier("testStatus"), colon
                                                            SimpleTypeIdentifierSyntax, identifier("String"), rightParen
                                                CodeBlockSyntax, leftBrace
                                                    CodeBlockItemListSyntax
                                                        CodeBlockItemSyntax
                                                            SequenceExprSyntax
                                                                ExprListSyntax
                                                                    MemberAccessExprSyntax
                                                                        IdentifierExprSyntax, selfKeyword, period, identifier("testStatus")
                                                                    AssignmentExprSyntax, equal
                                                                    IdentifierExprSyntax, identifier("testStatus")
                                                        CodeBlockItemSyntax
                                                            FunctionCallExprSyntax
                                                                MemberAccessExprSyntax
                                                                    SuperRefExprSyntax, superKeyword, period, identifier("init"), leftParen
                                                                FunctionCallArgumentListSyntax
                                                                    FunctionCallArgumentSyntax, identifier("name"), colon
                                                                        IdentifierExprSyntax, identifier("name"), comma
                                                                    FunctionCallArgumentSyntax, identifier("identifier"), colon
                                                                        IdentifierExprSyntax, identifier("identifier"), rightParen, rightBrace
                                        MemberDeclListItemSyntax
                                            InitializerDeclSyntax
                                                ModifierListSyntax
                                                    DeclModifierSyntax, publicKeyword
                                                    DeclModifierSyntax, identifier("required"), initKeyword
                                                ParameterClauseSyntax, leftParen
                                                    FunctionParameterListSyntax
                                                        FunctionParameterSyntax, identifier("from"), identifier("decoder"), colon
                                                            SimpleTypeIdentifierSyntax, identifier("Decoder"), rightParen, throwsKeyword
                                                CodeBlockSyntax, leftBrace
                                                    CodeBlockItemListSyntax
                                                        CodeBlockItemSyntax
                                                            VariableDeclSyntax, letKeyword
                                                                PatternBindingListSyntax
                                                                    PatternBindingSyntax
                                                                        IdentifierPatternSyntax, identifier("container")
                                                                        InitializerClauseSyntax, equal
                                                                            TryExprSyntax, tryKeyword
                                                                                FunctionCallExprSyntax
                                                                                    MemberAccessExprSyntax
                                                                                        IdentifierExprSyntax, identifier("decoder"), period, identifier("container"), leftParen
                                                                                    FunctionCallArgumentListSyntax
                                                                                        FunctionCallArgumentSyntax, identifier("keyedBy"), colon
                                                                                            MemberAccessExprSyntax
                                                                                                IdentifierExprSyntax, identifier("CodingKeys"), period, selfKeyword, rightParen
                                                        CodeBlockItemSyntax
                                                            SequenceExprSyntax
                                                                ExprListSyntax
                                                                    IdentifierExprSyntax, identifier("testStatus")
                                                                    AssignmentExprSyntax, equal
                                                                    TryExprSyntax, tryKeyword
                                                                        FunctionCallExprSyntax
                                                                            MemberAccessExprSyntax
                                                                                IdentifierExprSyntax, identifier("container"), period, identifier("decode"), leftParen
                                                                            FunctionCallArgumentListSyntax
                                                                                FunctionCallArgumentSyntax
                                                                                    MemberAccessExprSyntax
                                                                                        IdentifierExprSyntax, identifier("String"), period, selfKeyword, comma
                                                                                FunctionCallArgumentSyntax, identifier("forKey"), colon
                                                                                    MemberAccessExprSyntax, prefixPeriod, identifier("testStatus"), rightParen
                                                        CodeBlockItemSyntax
                                                            TryExprSyntax, tryKeyword
                                                                FunctionCallExprSyntax
                                                                    MemberAccessExprSyntax
                                                                        SuperRefExprSyntax, superKeyword, period, identifier("init"), leftParen
                                                                    FunctionCallArgumentListSyntax
                                                                        FunctionCallArgumentSyntax, identifier("from"), colon
                                                                            IdentifierExprSyntax, identifier("decoder"), rightParen, rightBrace
                                        MemberDeclListItemSyntax
                                            FunctionDeclSyntax
                                                ModifierListSyntax
                                                    DeclModifierSyntax, publicKeyword
                                                    DeclModifierSyntax, identifier("override"), funcKeyword, identifier("encode")
                                                FunctionSignatureSyntax
                                                    ParameterClauseSyntax, leftParen
                                                        FunctionParameterListSyntax
                                                            FunctionParameterSyntax, identifier("to"), identifier("encoder"), colon
                                                                SimpleTypeIdentifierSyntax, identifier("Encoder"), rightParen, throwsKeyword
                                                CodeBlockSyntax, leftBrace
                                                    CodeBlockItemListSyntax
                                                        CodeBlockItemSyntax
                                                            TryExprSyntax, tryKeyword
                                                                FunctionCallExprSyntax
                                                                    MemberAccessExprSyntax
                                                                        SuperRefExprSyntax, superKeyword, period, identifier("encode"), leftParen
                                                                    FunctionCallArgumentListSyntax
                                                                        FunctionCallArgumentSyntax, identifier("to"), colon
                                                                            IdentifierExprSyntax, identifier("encoder"), rightParen
                                                        CodeBlockItemSyntax
                                                            VariableDeclSyntax, varKeyword
                                                                PatternBindingListSyntax
                                                                    PatternBindingSyntax
                                                                        IdentifierPatternSyntax, identifier("container")
                                                                        InitializerClauseSyntax, equal
                                                                            FunctionCallExprSyntax
                                                                                MemberAccessExprSyntax
                                                                                    IdentifierExprSyntax, identifier("encoder"), period, identifier("container"), leftParen
                                                                                FunctionCallArgumentListSyntax
                                                                                    FunctionCallArgumentSyntax, identifier("keyedBy"), colon
                                                                                        MemberAccessExprSyntax
                                                                                            IdentifierExprSyntax, identifier("CodingKeys"), period, selfKeyword, rightParen
                                                        CodeBlockItemSyntax
                                                            TryExprSyntax, tryKeyword
                                                                FunctionCallExprSyntax
                                                                    MemberAccessExprSyntax
                                                                        IdentifierExprSyntax, identifier("container"), period, identifier("encode"), leftParen
                                                                    FunctionCallArgumentListSyntax
                                                                        FunctionCallArgumentSyntax
                                                                            IdentifierExprSyntax, identifier("testStatus"), comma
                                                                        FunctionCallArgumentSyntax, identifier("forKey"), colon
                                                                            MemberAccessExprSyntax, prefixPeriod, identifier("testStatus"), rightParen, rightBrace, rightBrace, rightBrace, eof
"""
        do {
            let parsed = try SyntaxParser.parse(source: source)
            let printer = SWSyntaxPrinter<String>()
            var output = ""
            printer.write(parsed, to: &output)
            XCTAssertEqual(output, syntax);
        } catch {
            XCTFail("\(error)")
        }
    }

    static var allTests = [
        ("testItPrints", testItPrints),
    ]
}
