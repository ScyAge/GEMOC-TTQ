Class {
	#name : 'GemocBinaryMessage',
	#superclass : 'GemocExpression',
	#instVars : [
		'left',
		'right'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'visiting' }
GemocBinaryMessage >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocBinaryMessage: self
]

{ #category : 'as yet unclassified' }
GemocBinaryMessage >> binarySymbol [
	^self subclassResponsibility 
]

{ #category : 'accessing' }
GemocBinaryMessage >> left: aGemocExpression [
	left := aGemocExpression 
]

{ #category : 'printing' }
GemocBinaryMessage >> printOn: aStream [

	left printOn: aStream.
	aStream space.
	aStream << self binarySymbol.
	aStream space.
	right printOn: aStream
]

{ #category : 'accessing' }
GemocBinaryMessage >> right: aGemocExpression [ 
	right := aGemocExpression
]
