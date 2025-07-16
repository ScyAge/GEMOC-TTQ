"
TraceLoaderUI is a presenter that help to load a Gemoc Trace in the system by using PyBridge

Usage : 
```
| test  res  anApp|

test := TraceLoaderUi newApplication: anApp 
							addBlockResult: [ :future  | res := future]; 
							yourself.
```

anApp is a SpApplication.

the Block is where the future of the trace will retrive.
The result will be in the variable res in the you open the presenter as a Modal or as a Dialog windows


"
Class {
	#name : 'TraceLoaderUI',
	#superclass : 'SpPresenter',
	#instVars : [
		'response',
		'toolBar',
		'blockLoader',
		'listTraceAvailable',
		'server',
		'textIp',
		'buttonSetSeverIp',
		'selectedItem',
		'hostIp',
		'actionBar'
	],
	#category : 'Gemoc-UI-Trace-loader-presenter',
	#package : 'Gemoc-UI-Trace-loader',
	#tag : 'presenter'
}

{ #category : 'adding' }
TraceLoaderUI >> addBlockResult: aBlock [ 

	blockLoader := aBlock 
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> alertIpMissing [

	(self instantiate: SpAlertDialog)
		label:
			'You need to be connected to a GEMOC sever. Put the IP and press set server IP';
		open
]

{ #category : 'initialization' }
TraceLoaderUI >> connectPresenters [

	listTraceAvailable whenSelectedItemChangedDo: [ :item | selectedItem := item. ].
]

{ #category : 'layout' }
TraceLoaderUI >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: textIp;
				   add: buttonSetSeverIp)
		  withConstraints: [ :cons |
			  cons
				  width: 100;
				  height: 50 ];
		  add: listTraceAvailable;
		  add: actionBar;
		  yourself
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> doGetTraceAction [

	^ response ifNotNil: [
		  response onSuccessDo: [ :v |
			  v status = 200 ifTrue: [ self notifyLoadTraceAction ] ] ]
]

{ #category : 'initialization' }
TraceLoaderUI >> initializeActionBar [

	| setTraceButton getTraceButton |
	actionBar := self newActionBar.


	setTraceButton := self newButton
		                  label: 'Set Trace';
		                  action: [
			                  selectedItem ifNotNil: [
					                  response := [
					                              server postTraceName: selectedItem ]
						                              future ] ].

	getTraceButton := self newButton
		                  label: 'Get Trace';
		                  action: [ self doGetTraceAction ].

	actionBar
		add: setTraceButton;
		add: getTraceButton
]

{ #category : 'initialization' }
TraceLoaderUI >> initializePresenters [

	listTraceAvailable := self newList.
	server := GemocTraceServerHandler new.
	textIp := self newTextInput.
	buttonSetSeverIp := self newButton
		                    label: 'set server ip';
		                    action: [
			                    textIp text isEmpty
				                    ifTrue: [
												self alertIpMissing.
					                     ]
				                    ifFalse: [
					                    server hostURL: textIp text.
					                    hostIp := textIp text ] ].
			
	self initializeActionBar.
]

{ #category : 'initialization' }
TraceLoaderUI >> initializeWindow: aWindow [

	| toolbar buttonFetchAllTrace |
	buttonFetchAllTrace := self newToolbarButton
		                       label: 'fetch all trace';
		                       icon: (self iconNamed: #smallAdd);
		                       action: [
			                       hostIp
				                       ifNil: [ self alertIpMissing ]
				                       ifNotNil: [
					                       listTraceAvailable items:
							                       server getFetchAllAvailableTrace ] ];
		                       yourself.

	toolbar := self newToolbar
		           add: buttonFetchAllTrace;
		           yourself.

	aWindow
		title: 'Trace Loader';
		initialExtent: 600 @ 400;
		toolbar: toolbar
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> loadTrace [

	^ server getParsedTrace.
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> notifyLoadTraceAction [

	^ blockLoader
		  ifNotNil: [ :block | block cull: self loadTrace ]
		  ifNil: [
			  Exception new
				  messageText:
					  'add a Block that retrive the result with addBlockResult:. ';
				  signal ]
]

{ #category : 'removing' }
TraceLoaderUI >> removeTrace [
	self model: nil.
]

{ #category : 'testing' }
TraceLoaderUI >> toolBar [

	^ toolBar
]
