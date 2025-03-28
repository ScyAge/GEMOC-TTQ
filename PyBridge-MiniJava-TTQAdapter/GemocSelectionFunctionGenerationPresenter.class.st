Class {
	#name : 'GemocSelectionFunctionGenerationPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'structuralFeatures',
		'selectedFeatures',
		'programModel'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-presenters',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'presenters'
}

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
