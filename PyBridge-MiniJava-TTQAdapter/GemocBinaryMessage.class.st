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

{ #category : 'accessing' }
GemocBinaryMessage >> left: aGemocExpression [
	left := aGemocExpression 
]

{ #category : 'accessing' }
GemocBinaryMessage >> right: aGemocExpression [ 
	right := aGemocExpression
]
