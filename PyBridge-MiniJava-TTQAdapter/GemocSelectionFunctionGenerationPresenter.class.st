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
GemocSelectionFunctionGenerationPresenter >> intializePresenters [

	structuralFeatures := self newList.
	selectedFeatures := self newList.
	structuralFeatures items: programModel keys
]

{ #category : 'initialization' }
GemocSelectionFunctionGenerationPresenter >> setModelBeforeInitialization: aGemocPythonProgramModel [
	
	programModel := aGemocPythonProgramModel __dict__ asNativeDict 
]
