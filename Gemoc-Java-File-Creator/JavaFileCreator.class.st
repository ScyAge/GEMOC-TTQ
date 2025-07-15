"
This class creates .java file with Java code in it


createJavaFileForClass: method for creating a java file for the class you specified the code in the file is generated with the JavaWrapperClassGenerator

The .java is generated in the directory 'generateJavaFileDirectory' by default wich is in your home directory.
You can change the name of the destination folder by using outPutFolderName: method and change the path where the directory is created by using defaultDestionationDirectory: method


Example: 

JavaWrapperFileCreator new createJavaFileForClass: GemocTraceServerHandler





"
Class {
	#name : 'JavaFileCreator',
	#superclass : 'Object',
	#instVars : [
		'home',
		'javaFileWrapper',
		'defaultDestinationDirectory',
		'outPutFolderName'
	],
	#category : 'Gemoc-Java-File-Creator-fileCreator',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'fileCreator'
}

{ #category : 'defaults' }
JavaFileCreator class >> defaultOutputFilename [ 

	^ 'generatedFile'
]

{ #category : 'testing' }
JavaFileCreator class >> isAbstract [

	^ self == JavaFileCreator
]

{ #category : 'as yet unclassified' }
JavaFileCreator >> createEndpointDirectory [


self getCompleteDirPath isDirectory ifFalse: [ self getCompleteDirPath ensureCreateDirectory ].
]

{ #category : 'as yet unclassified' }
JavaFileCreator >> createJavaFileFileRef: aClass [

	| name fileRef |
	name := aClass name.

	fileRef := (self getCompleteDirPath / (self getFileName: aClass))
		           asFileReference.

	fileRef exists ifTrue: [ fileRef delete ].
	fileRef ensureCreateFile.

	^ fileRef
]

{ #category : 'as yet unclassified' }
JavaFileCreator >> createJavaFileForClass: aClass [

	| fileRef |
	self createEndpointDirectory.
	fileRef := self createJavaFileFileRef: aClass.

	fileRef writeStreamDo: [ :aStream |
		(self generateContent: aClass) printOn: aStream ]
]

{ #category : 'accessing' }
JavaFileCreator >> defaultDestinationDirectory [

	^ defaultDestinationDirectory
]

{ #category : 'accessing' }
JavaFileCreator >> defaultDestinationDirectory: aFileLocator [

	defaultDestinationDirectory := aFileLocator
]

{ #category : 'hooks' }
JavaFileCreator >> generateContent: anObject [ 

	self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
JavaFileCreator >> getCompleteDirPath [ 

 ^ (defaultDestinationDirectory / outPutFolderName).
]

{ #category : 'hooks' }
JavaFileCreator >> getFileName: aClass [

	self subclassResponsibility.
]

{ #category : 'hooks' }
JavaFileCreator >> getJavaClassGenerator [

	self subclassResponsibility.
]

{ #category : 'hooks' }
JavaFileCreator >> getOutputFolderName [

	self subclassResponsibility.
]

{ #category : 'initialization' }
JavaFileCreator >> initialize [ 

javaFileWrapper := self getJavaClassGenerator.
defaultDestinationDirectory := FileLocator home.
outPutFolderName := self getOutputFolderName.
]

{ #category : 'accessing' }
JavaFileCreator >> javaFileWrapper: anAbstractJavaWrapper [

	javaFileWrapper := anAbstractJavaWrapper
]

{ #category : 'accessing' }
JavaFileCreator >> outPutFolderName [

	^ outPutFolderName ifNil: [ ^ self class defaultOutputFilename ]
]

{ #category : 'accessing' }
JavaFileCreator >> outPutFolderName: aString [

	outPutFolderName := aString
]
