Class {
	#name : 'GemocClassRef',
	#superclass : 'GemocSingleTypeRef',
	#instVars : [
		'name'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocClassRef >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocClassRef: self
]

{ #category : 'accessing' }
GemocClassRef >> name: aPyBridgeObjectLiteral [ 
	name := aPyBridgeObjectLiteral literalValue 
]

{ #category : 'printing' }
GemocClassRef >> printOn: aStream [

	self printName: name on: aStream
]
