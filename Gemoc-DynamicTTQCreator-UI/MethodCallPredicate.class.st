Class {
	#name : 'MethodCallPredicate',
	#superclass : 'AbstractTTQPrdedicate',
	#instVars : [
		'receiver',
		'selector',
		'argument'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-model',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'model'
}

{ #category : 'accessing' }
MethodCallPredicate >> argument [

	^ argument
]

{ #category : 'accessing' }
MethodCallPredicate >> argument: anObject [

	argument := anObject
]

{ #category : 'accessing' }
MethodCallPredicate >> receiver [

	^ receiver
]

{ #category : 'accessing' }
MethodCallPredicate >> receiver: anObject [

	receiver := anObject
]

{ #category : 'accessing' }
MethodCallPredicate >> selector [

	^ selector
]

{ #category : 'accessing' }
MethodCallPredicate >> selector: anObject [

	selector := anObject
]

{ #category : 'as yet unclassified' }
MethodCallPredicate >> verifyPredicate: arg [

^ true.
]
