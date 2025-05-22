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
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'tracepath',
		'toolBar',
		'previewer',
		'browser',
		'blockLoader'
	],
	#category : 'Gemoc-UI-Trace-loader',
	#package : 'Gemoc-UI-Trace-loader'
}

{ #category : 'adding' }
TraceLoaderUI >> addBlockResult: aBlock [ 

	blockLoader := aBlock 
]

{ #category : 'testing' }
TraceLoaderUI >> browser [

	^ browser
]

{ #category : 'initialization' }
TraceLoaderUI >> connectPresenters [

	self model ifNotNil: [ self transmitTo: previewer ]
]

{ #category : 'layout' }
TraceLoaderUI >> defaultLayout [ 
^ SpBoxLayout newTopToBottom
	add: previewer ;
	yourself
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> getFilePathFromBrowser [
 	| fileRef |
	fileRef := browser openModal.
	fileRef ifNotNil:[self model: fileRef].
	
	
]

{ #category : 'initialization' }
TraceLoaderUI >> initializeDialogWindow: aDialogPresenter [

	aDialogPresenter centered.
	aDialogPresenter okAction: [ self notifyLoadFutureAction ].
	
	aDialogPresenter
		addButton: 'Cancel' do: [ :button |
			button triggerCancelAction.
			button close ];
		addButton: 'Load Trace' do: [ :button |
			self model ifNotNil: [
					button
						triggerOkAction;
						beOk;
						close ] ]
]

{ #category : 'initialization' }
TraceLoaderUI >> initializePresenters [

	| fileSystemModel fileSystemPresenter root |
	fileSystemModel := StFileSystemModel new.
	fileSystemPresenter := StFileSystemPresenter on: fileSystemModel.
	self flag: 'root := FileLocator home.'.
	root := 'C:\Users\evanj\Documents\stage\gemoc\gemoc\minijava\modeling_workbench\minijava-examples\gemoc-gen\execution\execution-20241016_091542'
		        asFileLocatorOrReference.

	
	browser := (StOpenFilePresenter
		            owner: fileSystemPresenter
		            on: fileSystemModel) defaultFolder: root.

	previewer := self instantiate: PreviewerPathFile.
]

{ #category : 'initialization' }
TraceLoaderUI >> initializeWindow: aWindow [ 

| toolbar buttonAddTrace  buttonRemoveTrace | 

buttonAddTrace := self newToolbarButton
					label: 'add trace';
					icon: (self iconNamed: #smallAdd);
					action: [ self getFilePathFromBrowser];
					yourself.
					

								
buttonRemoveTrace := (self newToolbarButton 
							icon: (self iconNamed: #removeOptions);
							label: 'remove trace';
							action: [ self removeTrace ];
							yourself).
					
toolbar := self newToolbar
					add: buttonAddTrace;
					add: buttonRemoveTrace;
					yourself.
					


aWindow 
		title: 'Trace Loader';
		initialExtent: 600@400;
		toolbar: toolbar.
		
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> loadTraceInFuture [ 
| traceFuture path |

path := (self model) fullPath pathString withoutPrefix: '/'.

(self model) ifNotNil: [ 
traceFuture := [GemocTrace source: path] future.
].

^ traceFuture
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> notifyLoadFutureAction [

	^ blockLoader
		  ifNotNil: [ :block | block cull: self loadTraceInFuture ]
		  ifNil: [
			  Exception new
				  messageText:
					  'add a Block that retrive the result with addBlockResult:. ';
				  signal ]
]

{ #category : 'showing' }
TraceLoaderUI >> open [ 

	^ self openDialog.
]

{ #category : 'showing' }
TraceLoaderUI >> openModal [

	super openModal cancelled
		ifTrue: [ ^ nil ].
]

{ #category : 'testing' }
TraceLoaderUI >> previewer [

	^ previewer
]

{ #category : 'removing' }
TraceLoaderUI >> removeTrace [
	self model: nil.
]

{ #category : 'testing' }
TraceLoaderUI >> toolBar [

	^ toolBar
]

{ #category : 'testing' }
TraceLoaderUI >> tracepath [

	^ tracepath
]
