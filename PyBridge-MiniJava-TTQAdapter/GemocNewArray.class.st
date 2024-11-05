Class {
	#name : 'GemocNewArray',
	#superclass : 'GemocExpression',
	#instVars : [
		'type',
		'size'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocNewArray >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocNewArray: self
]

{ #category : 'printing' }
GemocNewArray >> printOn: aStream [
	aStream << 'new <'.
	aStream space.
	type printOn: aStream.
	aStream << '>['.
	size printOn: aStream.
	aStream << ']'.
]

{ #category : 'accessing' }
GemocNewArray >> size: aGemocIntConstant [

	size := aGemocIntConstant
]

{ #category : 'accessing - structure variables' }
GemocNewArray >> type: aGemocIntegerTypeRef [

	type := aGemocIntegerTypeRef
]
