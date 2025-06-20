"
A DynamicTTQCreatorPresenterTest is a test class for testing the behavior of DynamicTTQCreatorPresenter
"
Class {
	#name : 'DynamicTTQCreatorPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'dynamicInterface'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-Tests-Presenters',
	#package : 'Gemoc-DynamicTTQCreator-UI-Tests',
	#tag : 'Presenters'
}

{ #category : 'running' }
DynamicTTQCreatorPresenterTest >> setUp [

	super setUp.

	dynamicInterface := DynamicTTQCreatorPresenter
		                    newApplication: SpApplication new
		                    model: DynamicTTQCreator new.
		
	dynamicInterface open.
]

{ #category : 'running' }
DynamicTTQCreatorPresenterTest >> tearDown [ 

dynamicInterface ifNotNil: [ dynamicInterface delete ].

super tearDown 
]

{ #category : 'tests' }
DynamicTTQCreatorPresenterTest >> testCheckInitialization [ 

	self assert: (dynamicInterface model) predicateList size equals: 0.
	
	self assert: (dynamicInterface detailWrapper isKindOf: SpTextPresenter).
	
]

{ #category : 'tests' }
DynamicTTQCreatorPresenterTest >> testChooseAMetaModelElement [

	| oldPresenter |
	oldPresenter := dynamicInterface detailWrapper.

	dynamicInterface clickMetaModelElementAtIndex: 1.
	
	self deny: (oldPresenter isKindOf: dynamicInterface detailWrapper).
]
