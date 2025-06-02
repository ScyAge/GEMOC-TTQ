Class {
	#name : 'DynamicTTQCreatorPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
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
DynamicTTQCreatorPresenter class >> getTraceFromInterface [
	^ getTraceFromInterface
]

{ #category : 'initialization' }
DynamicTTQCreatorPresenter >> connectPresenters [

	listMetaModelElement whenSelectedItemChangedDo: [ :item |
		detailWrapper := self instantiate:
			                 item new gemocDynamicTTQCreatorDetailUI.
		detailWrapper setCallBackMethod: [ :predicate |
			self model addPredicteInList: predicate.
			listChoosenPredicate updateList ].
		self replaceLayoutWith: self defaultLayout ]
]

{ #category : 'accessing - model' }
DynamicTTQCreatorPresenter >> defaultInputPort [ 

^ SpModelPort newPresenter: self.
]

{ #category : 'layout' }
DynamicTTQCreatorPresenter >> defaultLayout [ 

^ SpBoxLayout newTopToBottom 
		spacing: 10;
		add: (SpBoxLayout newLeftToRight
				add: listMetaModelElement;
				add: detailWrapper );
		add: listChoosenPredicate .
]

{ #category : 'as yet unclassified' }
DynamicTTQCreatorPresenter >> getAllTheMetaModelElement [ 


^ GemocType allSubclasses.
]

{ #category : 'initialization' }
DynamicTTQCreatorPresenter >> initializePresenters [

	traceLoaderInterface := self instantiate: TraceLoaderUI on: nil.
	traceLoaderInterface addBlockResult: [ :futureRes | future := futureRes ].
	
	listMetaModelElement := self newList.
	listMetaModelElement items: (OrderedCollection newFrom: self getAllTheMetaModelElement).
	
	detailWrapper:= self newText.
	
	listChoosenPredicate := self newList.
	listChoosenPredicate items: self model predicateList.
	
]

{ #category : 'initialization' }
DynamicTTQCreatorPresenter >> initializeWindow: aWindow [

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
DynamicTTQCreatorPresenter >> loadTraceInThePresenter [

	traceLoaderInterface openModal.

	future ifNotNil: [
		future onSuccessDo: [ :v |
			self model trace: v.
			future := nil.
			self model trace inspect ] ]
]
