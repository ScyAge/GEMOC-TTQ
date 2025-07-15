"
This presenter helps a DSL creator to choose which element of the metamodel he wants to have wrapper. Once is selected the one he wants is selected and he chooses a destination directory, he can generate the wrapper with the help of the java file creator and generator.


you can just open it by doing 

```language=Pharo
   MMEWCPresenter new open.
```

note :

for the moment, the list is populated by getting all the subclasses of GemocType. In the future, the possibility to use something else is a must-have
"
Class {
	#name : 'MMEWCPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'chooserPresenter',
		'folderSelectorPresenter',
		'destFolder',
		'actionBar',
		'javaWrapperFileCreator',
		'javaAdapterFileCreator'
	],
	#category : 'Gemoc-MMEWC-presenter',
	#package : 'Gemoc-MMEWC',
	#tag : 'presenter'
}

{ #category : 'initialization' }
MMEWCPresenter >> canGenerateWrapper [

	^ chooserPresenter targetList items isEmpty not and: [
		  destFolder isNotNil]
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

	javaWrapperFileCreator defaultDestinationDirectory: destFolder.

	chooserPresenter targetList items do: [ :each |
		javaWrapperFileCreator createJavaFileForClass: each ].
	
	
	
	
]

{ #category : 'initialization' }
MMEWCPresenter >> initialize [

	super initialize.

	javaWrapperFileCreator := JavaWrappedFileCreator new.
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
self flag: 'the line below need to be change to allow the usage of an another list of element'.
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
			                   destFolder := folderSelectorPresenter openModal ];
		                   yourself.



	toolbar add: buttonChooseDir.


	aWindow
		title: 'MetaModel Element wrapper chooser';
		initialExtent: 1000 @ 600;
		toolbar: toolbar
]
