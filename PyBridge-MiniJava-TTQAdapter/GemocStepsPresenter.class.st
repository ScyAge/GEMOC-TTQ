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

{ #category : 'layout' }
GemocStepsPresenter >> defaultLayout [

	| newLayout |
	newLayout := SpBoxLayout newTopToBottom.
	newLayout add: stepsTable.
"	newLayout add: (SpPanedLayout newTopToBottom
			 positionOfSlider: 30 percent;
			 add: (SpBoxLayout newTopToBottom
					  add: 'Detected divergences'
					  expand: false
					  fill: false
					  padding: 5;
					  add: divergencesTable;
					  yourself);
			 add: (SpBoxLayout newLeftToRight
					  add: self referenceExecutionLayout;
					  add: self modifiedExecutionLayout;
					  yourself))."
	^ newLayout
]

{ #category : 'initialization' }
GemocStepsPresenter >> initializePresenters [

	stepsTable := self newTable.
	stepsTable addColumn: ((SpStringTableColumn
			  title: 'PC'
			  evaluated: [ :aGemocStep | self printPCFor: aGemocStep ])
			 width: 50;
			 yourself).
	stepsTable addColumn:
		(SpStringTableColumn title: 'Step' evaluated: [ :aGemocStep |
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
	steps := SortedCollection sortBlock: [ :a :b| a pc < b pc ].
	steps addAll: gemocSteps
]
