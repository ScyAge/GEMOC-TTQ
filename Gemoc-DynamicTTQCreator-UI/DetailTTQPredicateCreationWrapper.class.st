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
DetailTTQPredicateCreationWrapper >> setModel: MockModel [ 

	detail := self instantiate: (MockModel detailRepresentation). 
	
	self replaceLayoutWith: self defaultLayout . 
]
