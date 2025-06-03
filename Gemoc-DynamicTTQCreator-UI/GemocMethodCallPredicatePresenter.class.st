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

{ #category : 'as yet unclassified' }
GemocMethodCallPredicatePresenter >> createTTQObjectPredicate [

	^ TTQPredicate
		  newPredicateOn: GemocMethodCall
		  withDictionnary: (Dictionary newFrom: {
					   (#selector -> selector text).
					   (#receiver -> receiver text).
					   (#arguments -> arg text) })
]

{ #category : 'layout' }
GemocMethodCallPredicatePresenter >> defaultLayout [
^ SpBoxLayout newTopToBottom add: (SpGridLayout build: [ :builder |
		  builder
			  beColumnNotHomogeneous;
			  column: 2 expand: true;
			  add: 'receiver';
			  add: receiver;
			  nextRow;
			  add: 'selector';
			  add: selector;
			  nextRow;
			  add: 'argument';
			  add: arg ]) ;
		add: createPredicateButton withConstraints: [ :cons | cons width: 100 ; height: 50 ]
	 
]

{ #category : 'initialization' }
GemocMethodCallPredicatePresenter >> initializePresenters [ 

selector := self newTextInput.
arg := self newTextInput.
receiver := self newTextInput.

createPredicateButton := self newButton label: 'create predicate';
									action: [self sendPredicateCreated  ].
]
