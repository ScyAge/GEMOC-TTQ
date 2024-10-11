Class {
	#name : 'GemocSingleTypeRef',
	#superclass : 'GemocTypeRef',
	#instVars : [
		'name'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'accessing' }
GemocSingleTypeRef >> name: aPyBridgeObjectLiteralValue [ 
	name := aPyBridgeObjectLiteralValue
]

{ #category : 'printing' }
GemocSingleTypeRef >> printOn: aStream [

	self printName: name on: aStream
]
