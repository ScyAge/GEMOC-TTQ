Class {
	#name : 'GemocStepsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'steps',
		'stepsTable'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-presenters',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'presenters'
}

{ #category : 'initialization' }
GemocStepsPresenter >> initializePresenters [

	stepsTable := self newTable.
	stepsTable addColumn: ((SpStringTableColumn
			  title: 'PC'
			  evaluated: [ :aGemocStep | self printPCFor: aGemocStep ])
			 width: 200;
			 yourself).
	stepsTable addColumn:
		(SpStringTableColumn title: 'PC' evaluated: [ :aGemocStep |
			 String streamContents: [ :str | aGemocStep printOn: str ] ])
			yourself.
	stepsTable items: steps
]

{ #category : 'printing' }
GemocStepsPresenter >> printPCFor: aGemocStep [
	^aGemocStep pc printString
]

{ #category : 'accessing - model' }
GemocStepsPresenter >> setModelBeforeInitialization: gemocSteps [
	steps := gemocSteps
]
