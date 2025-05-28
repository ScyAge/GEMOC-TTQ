Class {
	#name : 'AbstractTTQPrdedicate',
	#superclass : 'Object',
	#category : 'Gemoc-DynamicTTQCreator-UI-model',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'model'
}

{ #category : 'testing' }
AbstractTTQPrdedicate class >> isAbstract [

	^ self == AbstractTTQPrdedicate
]

{ #category : 'as yet unclassified' }
AbstractTTQPrdedicate >> verifyPredicate: arg [

self subclassResponsibility.
]
