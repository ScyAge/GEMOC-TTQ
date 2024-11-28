Class {
	#name : 'GemocNewObject',
	#superclass : 'GemocExpression',
	#instVars : [
		'instantiation'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocNewObject >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocNewObject: self
]

{ #category : 'accessing' }
GemocNewObject >> instantiation: aString [ 
	instantiation := aString
]

{ #category : 'printing' }
GemocNewObject >> printOn: aStream [

	aStream << 'new'.
	aStream space.
	self printName: instantiation on: aStream.
	aStream << '()'
]
