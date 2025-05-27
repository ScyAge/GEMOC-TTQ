Class {
	#name : 'DynamicTTQCreator',
	#superclass : 'SpPresenter',
	#instVars : [
		'trace',
		'traceLoaderInterface',
		'listMetaModelElement',
		'listChoosenPredicate',
		'detailWrapper',
		'future'
	],
	#classInstVars : [
		'getTraceFromInterface'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-Presenters',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'Presenters'
}

{ #category : 'accessing' }
DynamicTTQCreator class >> getTraceFromInterface [
	^ getTraceFromInterface
]

{ #category : 'initialization' }
DynamicTTQCreator >> connectPresenters [ 

	listMetaModelElement transmitTo: detailWrapper 
]

{ #category : 'layout' }
DynamicTTQCreator >> defaultLayout [ 

^ SpBoxLayout newTopToBottom 
		add: (SpBoxLayout newLeftToRight
				add: listMetaModelElement;
				add: detailWrapper );
		add: listChoosenPredicate .
]

{ #category : 'as yet unclassified' }
DynamicTTQCreator >> getAllTheMetaModelElement [ 


^ GemocType allSubclasses.
]

{ #category : 'initialization' }
DynamicTTQCreator >> initializePresenters [

	traceLoaderInterface := self instantiate: TraceLoaderUI on: nil.
	traceLoaderInterface addBlockResult: [ :futureRes | future := futureRes ].
	
	listMetaModelElement := self newList.
	listMetaModelElement items: (OrderedCollection newFrom: self getAllTheMetaModelElement).
	
	listChoosenPredicate := self newList.
	
	detailWrapper := self instantiate: DetailTTQPredicateCreationWrapper.
]

{ #category : 'initialization' }
DynamicTTQCreator >> initializeWindow: aWindow [

| toolBar addTraceButton |

addTraceButton := self newToolbarButton 
						label: 'add trace';
						icon: (self iconNamed: #smallAdd);
						action: [ self loadTraceInThePresenter];
						yourself.
						
toolBar := self newToolbar 
					add: addTraceButton;
					yourself.
					
aWindow 
	title: 'Dynamic TTQ Generator';
	initialExtent: 1000@600;
	toolbar: toolBar.					
]

{ #category : 'as yet unclassified' }
DynamicTTQCreator >> loadTraceInThePresenter [

	traceLoaderInterface openModal.

	future ifNotNil: [
		future onSuccessDo: [ :v |
			trace := v.
			future := nil.
			trace inspect ] ]
]
