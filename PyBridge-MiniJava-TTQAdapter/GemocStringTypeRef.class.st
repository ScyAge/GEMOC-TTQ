Class {
	#name : 'GemocStringTypeRef',
	#superclass : 'GemocSingleTypeRef',
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocStringTypeRef >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocStringTypeRef: self
]
