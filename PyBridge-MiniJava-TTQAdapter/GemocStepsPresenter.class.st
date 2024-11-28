Class {
	#name : 'GemocStepsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'steps',
		'stepsTable',
		'trace',
		'code'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-presenters',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'presenters'
}

{ #category : 'layout' }
GemocStepsPresenter >> defaultLayout [

	| newLayout |
	newLayout := SpBoxLayout newTopToBottom.
	newLayout add: (SpPanedLayout newLeftToRight
			 positionOfSlider: 30 percent;
			 add: (SpBoxLayout newTopToBottom
					  add: 'Detected divergences'
					  expand: false
					  fill: false
					  padding: 5;
					  add: stepsTable;
					  yourself);
			 add: code;
			 yourself).
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
	stepsTable items: steps.
	stepsTable transmitDo: [ :step |
		step ifNotNil: [ self showStep: step ] ].
	stepsTable activateOnDoubleClick whenActivatedDo: [ :step |
		step selectedItem inspect ].

	code := self newCode
]

{ #category : 'printing' }
GemocStepsPresenter >> printPCFor: aGemocStep [
	^aGemocStep pc printString
]

{ #category : 'accessing - model' }
GemocStepsPresenter >> setModelBeforeInitialization: aGemocTrace [
	trace := aGemocTrace.
	steps := SortedCollection sortBlock: [ :a :b| a pc < b pc ].
	steps addAll: aGemocTrace gemocSteps
]

{ #category : 'private - presenters' }
GemocStepsPresenter >> showStep: step [

	code text:
		(String streamContents: [ :str | step nicePrintOn: str nbTabs: 0 ])
]
