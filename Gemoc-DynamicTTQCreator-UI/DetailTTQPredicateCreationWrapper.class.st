Class {
	#name : 'DetailTTQPredicateCreationWrapper',
	#superclass : 'SpPresenter',
	#instVars : [
		'detail'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI',
	#package : 'Gemoc-DynamicTTQCreator-UI'
}

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

	detail := self instantiate: (mockModel gemocDynamicTTQCreatorDetailUI). 
	
	self replaceLayoutWith: self defaultLayout . 
]
