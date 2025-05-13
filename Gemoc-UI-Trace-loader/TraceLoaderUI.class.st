Class {
	#name : 'TraceLoaderUI',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'tracepath',
		'toolBar',
		'previewer',
		'browser'
	],
	#category : 'Gemoc-UI-Trace-loader',
	#package : 'Gemoc-UI-Trace-loader'
}

{ #category : 'testing' }
TraceLoaderUI >> browser [

	^ browser
]

{ #category : 'initialization' }
TraceLoaderUI >> connectPresenters [ 

self transmitTo: previewer.
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

aDialogPresenter  centered.
aDialogPresenter 
	addButton: 'Cancel' do: [ :button | button close ];
	addButton: 'Load Trace' do: [ :button | self model ifNotNil: [button beOk ; close ]].
	
]

{ #category : 'initialization' }
TraceLoaderUI >> initializePresenters [

	| fileSystemModel fileSystemPresenter root |
	
	fileSystemModel := StFileSystemModel new.
	fileSystemPresenter := StFileSystemPresenter on: fileSystemModel.
	self flag: 'root := FileLocator home.'.
	root := 'C:\Users\evanj\Documents\stage\gemoc\gemoc\minijava\modeling_workbench\minijava-examples\gemoc-gen\execution\execution-20241016_091542' asFileLocatorOrReference.
	
	browser := (StOpenFilePresenter
		            owner: fileSystemPresenter
		            on: fileSystemModel) defaultFolder: root.
	
	previewer := self instantiate: PreviewerPathFile
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

{ #category : 'showing' }
TraceLoaderUI >> openModal [
	super openModal cancelled ifTrue: [ ^ nil ].
	^ self loadTraceInFuture
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
