Class {
	#name : 'DetailTTQPredicateCreationWrapper',
	#superclass : 'SpPresenter',
	#instVars : [
		'detail'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-Presenters',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'Presenters'
}

{ #category : 'accessing - model' }
DetailTTQPredicateCreationWrapper >> defaultInputPort [ 

^ SpModelPort newPresenter: self.
]

{ #category : 'layout' }
DetailTTQPredicateCreationWrapper >> defaultLayout [ 

^ SpBoxLayout newTopToBottom add: (detail) ; yourself
]

{ #category : 'initialization' }
DetailTTQPredicateCreationWrapper >> initializePresenters [ 

	detail := self newTextInput 
	
]

{ #category : 'accessing - model' }
DetailTTQPredicateCreationWrapper >> setModel: mockModel [ 

	detail := self instantiate: (mockModel new gemocDynamicTTQCreatorDetailUI). 
	
	self replaceLayoutWith: self defaultLayout . 
]
