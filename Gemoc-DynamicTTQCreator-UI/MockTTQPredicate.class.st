Class {
	#name : 'MockTTQPredicate',
	#superclass : 'AbstractTTQPredicateCreator',
	#instVars : [
		'accepButton',
		'textInput'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-Presenters',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'Presenters'
}

{ #category : 'as yet unclassified' }
MockTTQPredicate >> createTTQObjectPredicate [ 
	
]

{ #category : 'layout' }
MockTTQPredicate >> defaultLayout [ 

^ SpBoxLayout newTopToBottom 
	add: textInput ; 
	add: accepButton ;
	yourself
]

{ #category : 'initialization' }
MockTTQPredicate >> initializePresenters [ 

	textInput := self newTextInput.
	
	accepButton := self newButton label: 'choose this configuration';
											action: [ self sendPredicateCreated ]
]
