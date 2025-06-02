Class {
	#name : 'AbstractTTQPredicateCreator',
	#superclass : 'SpPresenter',
	#instVars : [
		'predicateCreationCallBack'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-Presenters',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'Presenters'
}

{ #category : 'testing' }
AbstractTTQPredicateCreator class >> isAbstract [

	^ self == AbstractTTQPredicateCreator
]

{ #category : 'as yet unclassified' }
AbstractTTQPredicateCreator >> createTTQObjectPredicate [ 
	self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
AbstractTTQPredicateCreator >> sendPredicateCreated [

	| predicate |
	predicate := self createTTQObjectPredicate.

	predicateCreationCallBack
		ifNil: [
			self error:
				'a call back block is needed, add one with setCallBackMetrod: ' ]
		ifNotNil: [ predicateCreationCallBack cull: predicate ]
]

{ #category : 'initialization' }
AbstractTTQPredicateCreator >> setCallBackMethod: block [

	predicateCreationCallBack := block
]
