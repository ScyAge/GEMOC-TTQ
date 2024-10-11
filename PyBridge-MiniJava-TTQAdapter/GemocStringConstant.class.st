Class {
	#name : 'GemocStringConstant',
	#superclass : 'GemocExpression',
	#instVars : [
		'value'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocStringConstant >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocStringConstant: self
]

{ #category : 'accessing' }
GemocStringConstant >> value: aString [ 
	value := aString
]
