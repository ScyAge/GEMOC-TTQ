Class {
	#name : 'AbstractTTQPredicateCreator',
	#superclass : 'SpPresenterWithModel',
	#category : 'Gemoc-DynamicTTQCreator-UI-Presenters',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'Presenters'
}

{ #category : 'testing' }
AbstractTTQPredicateCreator class >> isAbstract [

	^ self == AbstractTTQPredicateCreator
]

{ #category : 'initialization' }
AbstractTTQPredicateCreator >> connectPresenters [ 

self transmitTo: self owner.
]

{ #category : 'as yet unclassified' }
AbstractTTQPredicateCreator >> createTTQObjectPredicate [ 
	self subclassResponsibility.
]

{ #category : 'initialization' }
AbstractTTQPredicateCreator >> initialize [ 

self model: nil.
super initialize.

]
