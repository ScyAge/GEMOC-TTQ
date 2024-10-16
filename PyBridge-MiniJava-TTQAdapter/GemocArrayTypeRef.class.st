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

{ #category : 'as yet unclassified' }
GemocArrayTypeRef >> typeRef: aGemocIntegerTypeRef [ 
	typeRef := aGemocIntegerTypeRef
]
