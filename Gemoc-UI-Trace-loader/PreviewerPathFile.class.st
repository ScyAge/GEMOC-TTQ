Class {
	#name : 'PreviewerPathFile',
	#superclass : 'SpPresenter',
	#instVars : [
		'aFileReference',
		'pathPreviwer',
		'filePreviewer',
		'filePreviewerGenerator'
	],
	#category : 'Gemoc-UI-Trace-loader',
	#package : 'Gemoc-UI-Trace-loader'
}

{ #category : 'layout' }
PreviewerPathFile >> defaultInputPort [

	self flag: 'probleme iceberg'.

	^ SpModelPort newPresenter: self.
]

{ #category : 'layout' }
PreviewerPathFile >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 10;
		  add: pathPreviwer withConstraints: [ :constraint |
			  constraint
				  height: 50;
				  width: 100 ];
		  add: filePreviewer;
		  yourself
]

{ #category : 'initialization' }
PreviewerPathFile >> initializePresenters [ 


	
	pathPreviwer  := self newText.
	pathPreviwer beNotEditable.
	
	filePreviewerGenerator := StFileBrowserTextBasedPreviewer new.
	
	filePreviewer := self newTextInput.
	filePreviewer beNotEditable.


]

{ #category : 'accessing - model' }
PreviewerPathFile >> setModel: aFileRef [ 


aFileRef
		ifNil: [
			aFileReference  := nil.
			filePreviewer := self newTextInput.
			filePreviewer editable: false.
			pathPreviwer := self newTextInput.
			 ]
		ifNotNil: [
			aFileReference  := aFileRef.
			filePreviewer := filePreviewerGenerator basicPreviewOn: aFileReference.
			filePreviewer editable: false.
			pathPreviwer text: (aFileReference fullPath pathString withoutPrefix: '/')
			].

self replaceLayoutWith: self defaultLayout . 
]
