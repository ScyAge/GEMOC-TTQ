Class {
	#name : 'GemocIntConstant',
	#superclass : 'GemocExpression',
	#instVars : [
		'intValue'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocIntConstant >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocIntConstant: self
]

{ #category : 'as yet unclassified' }
GemocIntConstant >> intValue: anInteger [ 
	intValue := anInteger 
]
