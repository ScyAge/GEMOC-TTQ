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

{ #category : 'accessing' }
GemocNewArray >> size: aGemocIntConstant [

	size := aGemocIntConstant
]

{ #category : 'accessing - structure variables' }
GemocNewArray >> type: aGemocIntegerTypeRef [

	type := aGemocIntegerTypeRef
]
