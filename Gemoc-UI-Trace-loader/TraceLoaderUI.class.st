Class {
	#name : 'TraceLoaderUI',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'tracepath',
		'bottomBar',
		'toolBar',
		'previewer',
		'browser'
	],
	#category : 'Gemoc-UI-Trace-loader',
	#package : 'Gemoc-UI-Trace-loader'
}

{ #category : 'testing' }
TraceLoaderUI >> bottomBar [

	^ bottomBar
]

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
	addLast: bottomBar
	yourself
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> getFilePathFromBrowser [
 	| fileRef |
	fileRef := browser openModal.
	fileRef ifNotNil:[self model: fileRef].
	
	
]

{ #category : 'initialization' }
TraceLoaderUI >> initializePresenters [

	| fileSystemModel fileSystemPresenter root |
	
	fileSystemModel := StFileSystemModel new.
	fileSystemPresenter := StFileSystemPresenter on: fileSystemModel.
	root := FileLocator home.
	
	browser := (StOpenFilePresenter
		            owner: fileSystemPresenter
		            on: fileSystemModel) defaultFolder: root.
	
	previewer := self instantiate: PreviewerPathFile
]

{ #category : 'initialization' }
TraceLoaderUI >> initializeWindow: aWindow [ 

| toolbar buttonAddTrace buttonLoadTrace  buttonRemoveTrace | 

buttonAddTrace := self newToolbarButton
					label: 'add trace';
					icon: (self iconNamed: #smallAdd);
					action: [ self getFilePathFromBrowser];
					yourself.
					
buttonLoadTrace := 	(self newButton 
							icon:(self iconNamed: #smallAdd);
							label: 'load trace';
							action: [ self loadTrace ]
					 		yourself).	
								
buttonRemoveTrace := (self newToolbarButton 
							icon: (self iconNamed: #removeOptions);
							label: 'remove trace';
							action: [ self removeTrace ];
							yourself).
					
toolbar := self newToolbar
					add: buttonAddTrace;
					add: buttonRemoveTrace;
					yourself.
					

					
bottomBar := self newActionBar 
						add:  buttonLoadTrace;
						yourself.	



aWindow 
		title: 'Trace Loader';
		initialExtent: 600@400;
		toolbar: toolbar.
		
]

{ #category : 'as yet unclassified' }
TraceLoaderUI >> loadTrace [ 

(self model) ifNotNil: [ 
	[
	| test |
	test:= GemocTrace source: ((self model) fullPath pathString withoutPrefix: '/').
	
	test inspect
	] fork.
	 ]
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
