Class {
	#name : 'GemocType',
	#superclass : 'GemocAbstractModelRepresentation',
	#instVars : [
		'superTypes',
		'typeName',
		'typeClass'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'accessing' }
GemocType class >> step: aPyBridgeObject [ 
	|programState|
	programState := self new.
	programState executionStep: aPyBridgeObject.
	programState model: aPyBridgeObject semanticRuleStaticTarget value.
	^programState 
]

{ #category : 'printing' }
GemocType >> printName: aString on: aStream [

	aStream << (aString ifNil: [ '<name not found>' ])
]

{ #category : 'printing' }
GemocType >> printOn: aStream [

	aStream << (typeName ifNil: [ 'An undefined Gemoc type' ]).
	superTypes ifEmpty: [ ^ self ].
	aStream << ' (super types: '.
	superTypes do: [ :st |
		aStream << st typeName.
		aStream << (st == superTypes last
			 ifTrue: [ ')' ]
			 ifFalse: [ ', ' ]) ]
]

{ #category : 'accessing' }
GemocType >> superTypes [

	^ superTypes
]

{ #category : 'accessing' }
GemocType >> superTypes: anObject [

	superTypes := anObject
]

{ #category : 'accessing' }
GemocType >> typeClass [

	^ typeClass
]

{ #category : 'accessing' }
GemocType >> typeClass: anObject [

	typeClass := anObject
]

{ #category : 'accessing' }
GemocType >> typeName [

	^ typeName
]

{ #category : 'accessing' }
GemocType >> typeName: anObject [

	typeName := anObject
]

{ #category : 'reflective operations' }
GemocType >> uuid [
	^self model uuid
]
