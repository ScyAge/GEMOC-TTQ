"
This class abstraction is for representing all the subPresenter for creating a TTQ (for methodCall etc)

The subCall may be generated.


This hierarchie is principaly use with the **sendPredicateCreate** method this method put the object create by the abstract method **createTTQObjectPredicate** in the block set by **setCallBackMethod** if the parametred block is not set **sendPredicateCreate** will throw an error 



"
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
