Class {
	#name : 'GemocMinus',
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
GemocMinus >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocBinaryMessage: self
]

{ #category : 'accessing' }
GemocMinus >> left: aGemocExpression [ 
	left := aGemocExpression
]

{ #category : 'accessing' }
GemocMinus >> right: aGemocExpression [ 
	right := aGemocExpression
]
