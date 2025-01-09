Class {
	#name : 'GemocStepsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'steps',
		'stepsTable',
		'trace',
		'code',
		'tree',
		'rootStep',
		'queryTitle',
		'queryResultTable'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-presenters',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'presenters'
}

{ #category : 'layout' }
GemocStepsPresenter >> defaultLayout [

	| newLayout |
	newLayout := SpBoxLayout newTopToBottom.
	newLayout add: (SpBoxLayout newLeftToRight
			 add: (SpBoxLayout newTopToBottom
					  add: 'Execution steps'
					  expand: false
					  fill: false
					  padding: 5;
					  add: stepsTable;
					  yourself);
			 	add: (SpBoxLayout newTopToBottom
					  add: 'Execution tree'
					  expand: false
					  fill: false
					  padding: 5;
					  add: tree;
					  yourself);
				add: (SpBoxLayout newTopToBottom
					  add: 'Source code'
					  expand: false
					  fill: false
					  padding: 5;
					  add: code;
					  yourself);
			 yourself).
	^ newLayout
]

{ #category : 'ttq' }
GemocStepsPresenter >> executeTTQAllMessageSends [

	| ttq results |
	ttq := TTQAllMessageSends
		       safeQuerying: false;
		       queryFrom: steps.
	results := QSCollection solve: ttq.
	self showQueryResult: results forQuery: ttq
]

{ #category : 'initialization' }
GemocStepsPresenter >> initializePresenters [

	stepsTable := self newTable.
	stepsTable contextMenu: self ttqMenu.
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
		step ifNotNil: [ self selectStepInTree: step ] ].
	stepsTable activateOnDoubleClick whenActivatedDo: [ :step |
		step selectedItem inspect ].

	code := self newText.
	tree := self newTree.	
	tree	roots: {  };
		children: [ :step | step children ifNil:[{}]  ];
"		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];"
		display: [ :step | step gemocStep ruleName, ' ', step gemocStep printString ]
		"expandPath: #(1 1 3); ""Object/Exception/Notification""".
	tree transmitDo: [ :step |
		step ifNotNil: [ self showStep: step ] ].
	tree roots: { rootStep}.
	tree	activateOnDoubleClick whenActivatedDo: [ :step |
		step selectedItem inspect ].

	tree expandAll.
	



]

{ #category : 'initialization' }
GemocStepsPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'G-Seeker'
]

{ #category : 'printing' }
GemocStepsPresenter >> printPCFor: aGemocStep [
	^aGemocStep pc printString
]

{ #category : 'private - presenters' }
GemocStepsPresenter >> selectStepInTree: step [

	| treeElement |
	treeElement := trace executionTree
		               at: step uuid
		               ifAbsent: [ self halt ].

	tree selectItem: treeElement atIndex: (steps indexOf: step) - 3
]

{ #category : 'accessing - model' }
GemocStepsPresenter >> setModelBeforeInitialization: aGemocTrace [

	| validSteps |
	trace := aGemocTrace.
	steps := SortedCollection sortBlock: [ :a :b | a pc < b pc ].
	validSteps := aGemocTrace gemocSteps select: [ :step | step pc >= 0 ].
	rootStep := trace executionTree at: validSteps second uuid.
	rootStep inspect.
	
	steps addAll:
		(validSteps select: [ :step | step isStatementEvaluation ])
]

{ #category : 'private - presenters' }
GemocStepsPresenter >> showQueryResult: results forQuery: aTTQ [

	| queryDisplayModel spColumns |
	queryDisplayModel := aTTQ displayModel.
	queryTitle := queryDisplayModel title.

	spColumns := OrderedCollection new.
	spColumns add: (SpIndexTableColumn new width: 40).

	spColumns addAll: (queryDisplayModel columns collect: [ :each |
			 (SpStringTableColumn
				  title: each label
				  evaluated: [ :row |
					  self ttqResultTrimmingBlock value: row value: each ])
				 beExpandable;
				 yourself ]).

	queryResultTable := self newTable.
	queryResultTable columns: spColumns.
	queryResultTable items: results.
	self layout: self ttqLayout
]

{ #category : 'private - presenters' }
GemocStepsPresenter >> showStep: step [

	code text:
		(String streamContents: [ :str | step gemocStep nicePrintOn: str nbTabs: 0 ])
]

{ #category : 'layout' }
GemocStepsPresenter >> ttqLayout [

	| ttqLayout newLayout |
	
	newLayout := SpBoxLayout newTopToBottom.
	newLayout add: (SpBoxLayout newLeftToRight
			 add: (SpBoxLayout newTopToBottom
					  add: 'Execution steps'
					  expand: false
					  fill: false
					  padding: 5;
					  add: stepsTable;
					  yourself);
			 add: (SpBoxLayout newTopToBottom
					  add: 'Execution tree'
					  expand: false
					  fill: false
					  padding: 5;
					  add: tree;
					  yourself);
			 add: (SpBoxLayout newTopToBottom
					  add: 'Source code'
					  expand: false
					  fill: false
					  padding: 5;
					  add: code;
					  yourself);
			 yourself).
		ttqLayout := SpPanedLayout newTopToBottom.
		ttqLayout positionOfSlider: 60 percent.
		ttqLayout add: newLayout.
		ttqLayout add: (SpBoxLayout newTopToBottom
					  add: 'Query result'
					  expand: false
					  fill: false
					  padding: 5;
					  add: queryResultTable;
					  yourself).
	^ ttqLayout
]

{ #category : 'initialization' }
GemocStepsPresenter >> ttqMenu [

	^ self newMenu
		  title: 'Time-Traveling Queries';
		  addGroup: [ :aGroup |
			  aGroup
				  addItem: [ :anItem |
					  anItem
						  name: 'Find all message sends';
						  iconName: #smallObjects;
						  action: [ self executeTTQAllMessageSends ] ];
				  addItem: [ :anItem |
					  anItem
						  name: 'Find all assignments';
						  iconName: #smallLanguage;
						  action: [ self executeTTQAllAssignments ] ];
				  addItem: [ :anItem |
					  anItem
						  name: 'Find all instance creations';
						  iconName: #smallNew;
						  action: [ self executeTTQAllInstantiations ] ] ]
]

{ #category : 'private - presenters' }
GemocStepsPresenter >> ttqResultTrimmingBlock [

	^ [ :row :col |
	  col expandable
		  ifTrue: [ (col readValueIn: row) asString ]
		  ifFalse: [
			  (col readValueIn: row) asString
				  trimForRenderWidth: col width
				  usingFont: StandardFonts listFont
				  autoEllipsis: true ] ]
]
