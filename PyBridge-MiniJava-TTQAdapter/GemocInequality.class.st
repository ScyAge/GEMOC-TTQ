Class {
	#name : 'GemocInequality',
	#superclass : 'GemocExpression',
	#instVars : [
		'left',
		'right'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocInequality >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocBinaryMessage: self
]

{ #category : 'accessing' }
GemocInequality >> left: aGemocExpression [
	left := aGemocExpression 
]

{ #category : 'accessing' }
GemocInequality >> right: aGemocExpression [ 
	right := aGemocExpression
]
