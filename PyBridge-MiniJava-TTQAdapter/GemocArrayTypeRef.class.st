Class {
	#name : 'GemocArrayTypeRef',
	#superclass : 'GemocTypeRef',
	#instVars : [
		'typeRef'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocArrayTypeRef >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitArrayTypeRef: self
]

{ #category : 'printing' }
GemocArrayTypeRef >> printOn: aStream [
	typeRef printOn: aStream
]

{ #category : 'as yet unclassified' }
GemocArrayTypeRef >> typeRef: aGemocIntegerTypeRef [ 
	typeRef := aGemocIntegerTypeRef
]
