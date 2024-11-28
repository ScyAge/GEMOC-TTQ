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
	GemocProgramStateGenerator new visit: self
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
