Class {
	#name : 'AbstractTTQPredicateCreator',
	#superclass : 'SpPresenter',
	#category : 'Gemoc-DynamicTTQCreator-UI',
	#package : 'Gemoc-DynamicTTQCreator-UI'
}

{ #category : 'testing' }
AbstractTTQPredicateCreator class >> isAbstract [

	^ self == AbstractTTQPredicateCreator
]

{ #category : 'as yet unclassified' }
AbstractTTQPredicateCreator >> createTTQObjectPredicate [ 
	self subclassResponsibility.
]
