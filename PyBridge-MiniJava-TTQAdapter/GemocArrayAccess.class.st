Class {
	#name : 'GemocArrayAccess',
	#superclass : 'GemocExpression',
	#instVars : [
		'arrayObject',
		'accessIndex'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocArrayAccess >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocArrayAccess: self
]

{ #category : 'as yet unclassified' }
GemocArrayAccess >> accessIndex: aGemocIntConstant [

	accessIndex := aGemocIntConstant
]

{ #category : 'as yet unclassified' }
GemocArrayAccess >> arrayObject: aGemocSymbolRef [

	arrayObject := aGemocSymbolRef
]

{ #category : 'printing' }
GemocArrayAccess >> printOn: aStream [
	arrayObject printOn: aStream.
	accessIndex printOn: aStream
]
