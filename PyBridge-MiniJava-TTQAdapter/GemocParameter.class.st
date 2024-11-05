Class {
	#name : 'GemocParameter',
	#superclass : 'GemocSymbol',
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocParameter >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocParam: self
]

{ #category : 'printing' }
GemocParameter >> printOn: aStream [
	aStream << name.
	aStream << ' ('.
	typeRef printOn: aStream.
	aStream << ')'. 
]
