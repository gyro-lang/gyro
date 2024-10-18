// Compiles the generated ast to assembly

import { parse } from "./gyro-grammar";
import crypto from "crypto";

interface BaseNode {
	type: "Program" | "FunctionDeclaration" | "BlockStatement" | "ReturnStatement" | "VariableDeclaration" | "VariableDeclarator" | "CallExpression" | "Identifier" | "Decorator" | "Literal",
}

interface ProgramNode extends BaseNode {
	type: "Program",
	body: BaseNode[]
}

interface FunctionDeclarationNode extends BaseNode {
	type: "FunctionDeclaration",
	id: IdentifierNode,
	decorators: DecoratorNode[],
	// TODO
	params: any[],
	body: BlockStatementNode
}

interface BlockStatementNode extends BaseNode {
	type: "BlockStatement",
	body: BaseNode[]
}

interface IdentifierNode extends BaseNode {
	type: "Identifier",
	name: string
}

interface DecoratorNode extends BaseNode {
	type: "Decorator",
	name: string,
	// TODO
	params: any
}

interface ReturnStatementNode extends BaseNode {
	type: "ReturnStatement",
	argument: BaseNode | null
}

interface VariableDeclarationNode extends BaseNode {
	type: "VariableDeclaration",
	declarations: VariableDeclaratorNode[],
	kind: "var" | "const" | "let",
	decorators: DecoratorNode[]
}

interface VariableDeclaratorNode extends BaseNode {
	type: "VariableDeclarator",
	// TODO
	init: LiteralNode,
	id: IdentifierNode
}

interface LiteralNode extends BaseNode {
	type: "Literal",
	value: boolean | string | number
}

interface CallExpressionNode extends BaseNode {
	type: "CallExpression",
	// TODO
	callee: IdentifierNode
}

function visit(ast: BaseNode) {
	if (!(ast.type in visitors)) {
		throw new Error(`Visitor not defined for type '${ast.type}'`)
	}

	visitors[ast.type].call(null, ast);
}

function compile(input: string) {
	const ast = parse(input);
	
	visit(ast)

	if (!scope.has("main") || scope.get("main")?.type !== "Function") {
		throw new Error("Missing function 'main'")
	}
}


const scope: Map<string, {
	offset: number,
	type: "Function" | "Variable"
}> = new Map();
let stackOffset: number = 0;
const output: string[] = []

function find(nodes: BaseNode[], predicate: (ast: BaseNode) => boolean) {
	for (const node of nodes) {
		if (predicate(node)) {
			return node;
		}
	}
}

const visitors: Record<BaseNode["type"], (ast: any) => void> = {
	FunctionDeclaration(ast: FunctionDeclarationNode) {
		scope.set(ast.id.name, {
			offset: 0,
			type: "Function"
		})

		output.push(`${ast.id.name}:`, "	push ebp", "	mov ebp, esp")
		visit(ast.body)

		// Check if the function returns by itself

		if (!find(ast.body.body, (node) => node.type === "ReturnStatement")) {
			output.push("	pop ebp", "	ret")
		}

	},
	Program(ast: ProgramNode) {
		output.push("global _start", "_start:")
		output.push("	call main", "exit:", "	mov eax, 1", "	int 0x80")
		for (const node of ast.body) {
			visit(node)
		}
	},
	BlockStatement(ast: BlockStatementNode) {
		for (const node of ast.body) {
			visit(node)
		}
	},
	CallExpression(ast: CallExpressionNode) {
		output.push(`	call ${ast.callee.name}`)
	},
	Decorator(ast: DecoratorNode) {
		console.log(ast);
		
	},
	Identifier() {

	},
	Literal(ast: LiteralNode) {
		output.push("	mov eax, " + ast.value.toString())
	},
	ReturnStatement(ast: ReturnStatementNode) {
		if (ast.argument !== null) {
			visit(ast.argument)
		}

		output.push("	pop ebp", "	ret")
	},
	VariableDeclaration(ast: VariableDeclarationNode) {
		for (const decorator of ast.decorators) {
			visit(decorator)
		}
		for (const node of ast.declarations) {
			visit(node)
		}
	},
	VariableDeclarator(ast: VariableDeclaratorNode) {
		let offset = 0;
		if (scope.has(ast.id.name)) {
			offset = scope.get(ast.id.name)?.offset as number;
		} else {
			offset = (stackOffset -= 4);
		}

		visit(ast.init)
		output.push(`	mov [ebp${offset < 0 ? "-" : "+"}${Math.abs(offset)}], eax`)

	}
}


compile(`fn main() {
	@compiled var x = name()
}

fn name() {
	return 5;
}`)

console.log(output.join("\n"))