Class {
	#name : 'GemocPrintStatement',
	#superclass : 'GemocType',
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

{ #category : 'instance creation' }
GemocPrintStatement >> expression: aGemocSymbolRef [ 
	expression := aGemocSymbolRef
]

{ #category : 'printing' }
GemocPrintStatement >> printOn: aStream [
	aStream << '[PRINT]'.
	aStream space.
	aStream << 'System.out.println('.
	expression printOn: aStream.
	aStream << ')'.
]
