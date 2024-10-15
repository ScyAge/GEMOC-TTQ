Class {
	#name : 'GemocPrintStatement',
	#superclass : 'GemocProgramState',
	#instVars : [
		'expression'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'visiting' }
GemocPrintStatement >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocPrintStatement: self
]

{ #category : 'building' }
GemocPrintStatement >> build [
	self acceptVisitor: GemocProgramStateGenerator new
]

{ #category : 'instance creation' }
GemocPrintStatement >> expression: aGemocSymbolRef [ 
	expression := aGemocSymbolRef
]

{ #category : 'printing' }
GemocPrintStatement >> printOn: aStream [
	aStream << 'print:'.
	aStream space.
	expression printOn: aStream
]
