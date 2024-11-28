Class {
	#name : 'GemocArrayLength',
	#superclass : 'GemocExpression',
	#instVars : [
		'array'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocArrayLength >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocArrayLength: self
]

{ #category : 'accessing' }
GemocArrayLength >> array: aGemocSymbolRef [ 
	array := aGemocSymbolRef
]

{ #category : 'printing' }
GemocArrayLength >> printOn: aStream [

	aStream << (typeName ifNil: [ 'An undefined Gemoc type' ]).
	aStream space.
	array printOn: aStream 
]
