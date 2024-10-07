Class {
	#name : 'GemocType',
	#superclass : 'Object',
	#instVars : [
		'superTypes',
		'model',
		'typeName'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter',
	#package : 'PyBridge-MiniJava-TTQAdapter'
}

{ #category : 'accessing' }
GemocType >> model [

	^ model
]

{ #category : 'accessing' }
GemocType >> model: anObject [

	model := anObject
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
GemocType >> typeName [

	^ typeName
]

{ #category : 'accessing' }
GemocType >> typeName: anObject [

	typeName := anObject
]
