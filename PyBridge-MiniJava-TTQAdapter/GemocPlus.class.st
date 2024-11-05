Class {
	#name : 'GemocPlus',
	#superclass : 'GemocBinaryMessage',
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocPlus >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocBinaryMessage: self
]

{ #category : 'as yet unclassified' }
GemocPlus >> binarySymbol [
	^'+'
]
