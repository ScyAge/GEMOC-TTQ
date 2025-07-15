"
This presenter is for creating TTQ selection fonction or prediacte (to define ) base on the list of the subclass of GemocType or the list of element we receive from the connection with gemoc (to define).

The element create are stock and can be use for to create TTQ.


This presenter need to be instanciate with the model DynamicTTQCreator.

```language=Pharo&caption=Beautiful&anchor=Fig1
   |app loader |

	app := DynamicTTQCreatorApp new.


	loader := DynamicTTQCreatorPresenter newApplication: app model: (DynamicTTQCreator new).


	loader open.
```
"
Class {
	#name : 'DynamicTTQCreatorPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'traceLoaderInterface',
		'listMetaModelElement',
		'listChoosenPredicate',
		'detailWrapper'
	],
	#classInstVars : [
		'getTraceFromInterface'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-Presenters',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'Presenters'
}

{ #category : 'private - testing' }
DynamicTTQCreatorPresenter >> clickMetaModelElementAtIndex: index [

	listMetaModelElement clickAtIndex: index
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

{ #category : 'layout' }
DynamicTTQCreatorPresenter >> defaultLayout [ 

^ SpBoxLayout newTopToBottom 
		spacing: 10;
		add: (SpBoxLayout newLeftToRight
				add: listMetaModelElement;
				add: detailWrapper );
		add: listChoosenPredicate .
]

{ #category : 'private - testing' }
DynamicTTQCreatorPresenter >> detailWrapper [

	^ detailWrapper
]

{ #category : 'as yet unclassified' }
DynamicTTQCreatorPresenter >> getAllTheMetaModelElement [
	"Specific method to get elements from the GemocType hierarchie"
	self flag: 'this method may be removed'.
	^ GemocType allSubclasses
]

{ #category : 'initialization' }
DynamicTTQCreatorPresenter >> initializePresenters [

	traceLoaderInterface := self instantiate: TraceLoaderUI on: nil.
	
	listMetaModelElement := self newList.
	self flag: 'the line below may be remove te add a custom add of the element to select'.
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

{ #category : 'private - testing' }
DynamicTTQCreatorPresenter >> listChoosenPredicate [

	^ listChoosenPredicate
]

{ #category : 'private - testing' }
DynamicTTQCreatorPresenter >> listMetaModelElement [

	^ listMetaModelElement
]

{ #category : 'as yet unclassified' }
DynamicTTQCreatorPresenter >> loadTraceInThePresenter [
	| future |
	
	traceLoaderInterface addBlockResult: [ :futureRes | future := futureRes ].
	traceLoaderInterface openModal.
	
	future ifNotNil: [
		future onSuccessDo: [ :v |
			self model trace: v.
			self model trace inspect ] ]
]

{ #category : 'private - testing' }
DynamicTTQCreatorPresenter >> traceLoaderInterface [

	^ traceLoaderInterface
]
