Class {
	#name : 'GemocMethodCallPredicatePresenter',
	#superclass : 'AbstractTTQPredicateCreator',
	#instVars : [
		'arg',
		'receiver',
		'selector',
		'createPredicateButton'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-Presenters',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'Presenters'
}

{ #category : 'initialization' }
GemocMethodCallPredicatePresenter >> initializePresenters [ 

selector := self newTextInput.
arg := self newTextInput.
receiver := self newTextInput.

createPredicateButton := self newButton.
]
