Class {
	#name : 'GemocInferior',
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
GemocInferior >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocBinaryMessage: self
]

{ #category : 'accessing' }
GemocInferior >> left: aGemocExpression [ 
	left := aGemocExpression
]

{ #category : 'accessing' }
GemocInferior >> right: aGemocExpression [

	right := aGemocExpression
]
