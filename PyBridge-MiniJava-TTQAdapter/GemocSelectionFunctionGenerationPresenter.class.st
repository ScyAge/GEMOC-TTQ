Class {
	#name : 'GemocSelectionFunctionGenerationPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'structuralFeatures',
		'selectedFeatures',
		'programModel',
		'menuBar'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-presenters',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'presenters'
}

{ #category : 'initialization' }
GemocSelectionFunctionGenerationPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: structuralFeatures;
				   add: selectedFeatures;
				   yourself);
		  add: menuBar expand: false;
		  yourself
]

{ #category : 'initialization' }
GemocSelectionFunctionGenerationPresenter >> initializePresenters [

	structuralFeatures := self newList.
	selectedFeatures := self newList.
	structuralFeatures items: programModel keys.
	menuBar := self newButtonBar.
	menuBar placeAtEnd;
		add: (self newButton
			icon: (self application iconNamed: #smallAdd);
			label: 'Generate';
			yourself);
		add: (self newButton
			icon: (self application iconNamed: #smallDelete);
			label: 'Delete';
			yourself);
		add: (self newButton
			icon: (self application iconNamed: #smallCopy);
			label: 'Copy';
			yourself).

]

{ #category : 'initialization' }
GemocSelectionFunctionGenerationPresenter >> setModelBeforeInitialization: aGemocPythonProgramModel [
	
	programModel := aGemocPythonProgramModel __dict__ asNativeDict 
]
