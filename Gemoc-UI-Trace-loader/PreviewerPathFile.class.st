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
PreviewerPathFile >> defaultLayout [ 

^ SpPanedLayout newLeftToRight
	add: pathPreviwer ;
	add:filePreviewer ;
	yourself.
]

{ #category : 'initialization' }
PreviewerPathFile >> initializePresenters [ 


	
	pathPreviwer  := self newTextInput.
	pathPreviwer editable: false.
	
	filePreviewerGenerator := StFileBrowserTextBasedPreviewer new.
	
	filePreviewer := self newTextInput.
	filePreviewer editable: false.


]

{ #category : 'accessing - model' }
PreviewerPathFile >> setModel: aFileRef [ 

aFileRef
		ifNil: [
			aFileReference  := nil.
			filePreviewer := self newTextInput.
			filePreviewer editable: false.
			 ]
		ifNotNil: [
			aFileReference  := aFileRef.
			filePreviewer := filePreviewerGenerator basicPreviewOn: aFileReference.
			pathPreviwer text: aFileReference asPath pathString
			].
		
self layout replaceSecond: filePreviewer . 
]
