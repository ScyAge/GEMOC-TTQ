Class {
	#name : 'GemocIntegerTypeRef',
	#superclass : 'GemocSingleTypeRef',
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocIntegerTypeRef >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocIntegerTypeRef: self
]
