Class {
	#name : 'MMEWCPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'chooserPresenter',
		'folderSelectorPresenter',
		'destFolder',
		'actionBar',
		'javaWrapperFileCreator'
	],
	#category : 'Gemoc-MMEWC-presenter',
	#package : 'Gemoc-MMEWC',
	#tag : 'presenter'
}

{ #category : 'initialization' }
MMEWCPresenter >> canGenerateWrapper [

^  (chooserPresenter targetList items isEmpty not) and: [ destFolder isNotNil ]
]

{ #category : 'layout' }
MMEWCPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: chooserPresenter;
		  add: actionBar withConstraints: [ :cons |
			  cons
				  height: 50;
				  width: 100 ];
		  yourself
]

{ #category : 'as yet unclassified' }
MMEWCPresenter >> generateJavaFile [

	chooserPresenter targetList items do: [ :each |
		javaWrapperFileCreator createJavaFileForClass: each ]
]

{ #category : 'initialization' }
MMEWCPresenter >> initialize [ 

super initialize.

javaWrapperFileCreator := JavaWrapperFileCreator new.
]

{ #category : 'initialization' }
MMEWCPresenter >> initializeActionBar [

	| buttonProcedCreationWrapper |
	actionBar := self newActionBar.

	buttonProcedCreationWrapper := self newButton
		                               label: 'Proceed Generation';
		                               icon: (self iconNamed: #smallPublish);
		                               action: [
			                               self canGenerateWrapper ifTrue: [
					                               self generateJavaFile ] ];
		                               yourself.

	actionBar add: buttonProcedCreationWrapper
]

{ #category : 'initialization' }
MMEWCPresenter >> initializePresenters [ 

chooserPresenter := self instantiate: SpChooserPresenter .
chooserPresenter sourceItems: (GemocType allSubclasses).


folderSelectorPresenter := (StOpenDirectoryPresenter new defaultFolder: (FileLocator home) asFileReference) .

self initializeActionBar.
]

{ #category : 'initialization' }
MMEWCPresenter >> initializeWindow: aWindow [

	| toolbar buttonChooseDir |
	toolbar := self newToolbar.


	buttonChooseDir := self newToolbarButton
		                   label: 'chooseDestinationFolder';
		                   icon: (self iconNamed: #smallAdd);
		                   action: [
			                   destFolder := folderSelectorPresenter openModal.
			                   javaWrapperFileCreator
				                   defaultDestinationDirectory: destFolder ];
		                   yourself.



	toolbar add: buttonChooseDir.


	aWindow
		title: 'MetaModel Element wrapper chooser';
		initialExtent: 1000 @ 600;
		toolbar: toolbar
]
