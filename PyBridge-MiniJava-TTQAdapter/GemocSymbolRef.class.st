Class {
	#name : 'GemocSymbolRef',
	#superclass : 'GemocExpression',
	#instVars : [
		'symbol'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocSymbolRef >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocSymbolRef: self
]

{ #category : 'printing' }
GemocSymbolRef >> printOn: aStream [
	 symbol printOn: aStream
]

{ #category : 'accessing' }
GemocSymbolRef >> symbol: aGemocVariableDeclaration [ 
	symbol := aGemocVariableDeclaration
]
