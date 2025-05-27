Class {
	#name : 'AbstractTTQPredicateCreator',
	#superclass : 'SpPresenter',
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
