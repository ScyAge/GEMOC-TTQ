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

{ #category : 'printing' }
GemocStringConstant >> printOn: aStream [
	aStream << '"'.
	aStream << value.
	aStream << '"'
]

{ #category : 'accessing' }
GemocStringConstant >> value: aString [ 
	value := aString
]
