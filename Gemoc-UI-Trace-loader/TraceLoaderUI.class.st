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
TraceLoaderUI >> getFilePath [
 	| fileRef |
	fileRef := browser openModal.
	fileRef ifNotNil:[self model: fileRef]
	
	
]

{ #category : 'initialization' }
TraceLoaderUI >> initializePresenters [

	| fileSystemModel fileSystemPresenter root |
	fileSystemModel := StFileSystemModel new.
	fileSystemPresenter := StFileSystemPresenter on: fileSystemModel.
	root := StFileSystemResource current root.
	browser := (StOpenFilePresenter
		            owner: fileSystemPresenter
		            on: fileSystemModel) defaultFolder: root.
	previewer := self instantiate: PreviewerPathFile
]

{ #category : 'initialization' }
TraceLoaderUI >> initializeWindow: aWindow [ 

| toolbar button button2 | 

button := self newToolbarButton
					label: 'add trace';
					icon: (self iconNamed: #smallAdd);
					action: [ self getFilePath];
					yourself.
					
toolbar := self newToolbar
					add: button;
					yourself.
					
button2 := 	(self newButton 
							icon:(self iconNamed: #smallAdd);
							label: 'load trace';
					 		yourself).		
					
bottomBar := self newActionBar 
						add:  button2;
						yourself.	



aWindow 
		title: 'Trace Loader';
		initialExtent: 600@400;
		toolbar: toolbar.
		
]
