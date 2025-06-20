"
This class creates .java file with Java code in it


createJavaFileForClass: method for creating a java file for the class you specified the code in the file is generated with the JavaWrapperClassGenerator

The .java is generated in the directory 'generateJavaFileDirectory' by default wich is in your home directory.
You can change the name of the destination folder by using outPutFolderName: method and change the path where the directory is created by using defaultDestionationDirectory: method


Example: 

JavaWrapperFileCreator new createJavaFileForClass: GemocTraceServerHandler





"
Class {
	#name : 'JavaWrapperFileCreator',
	#superclass : 'Object',
	#instVars : [
		'home',
		'javaFileWrapper',
		'defaultDestinationDirectory',
		'outPutFolderName'
	],
	#category : 'Gemoc-Java-File-Creator',
	#package : 'Gemoc-Java-File-Creator'
}

{ #category : 'as yet unclassified' }
JavaWrapperFileCreator >> createEndpointDirectory [


self getCompleteDirPath isDirectory ifFalse: [ self getCompleteDirPath ensureCreateDirectory ].
]

{ #category : 'as yet unclassified' }
JavaWrapperFileCreator >> createJavaFileFileRef: aClass [

	| name fileRef |
	name := aClass name.

	fileRef := (self getCompleteDirPath
	            /
	            ((javaFileWrapper generateTrueClassName: aClass)
	             , 'Wrapper' , '.java')) asFileReference.

	fileRef exists ifTrue: [ fileRef delete ].
	fileRef ensureCreateFile.

	^ fileRef
]

{ #category : 'as yet unclassified' }
JavaWrapperFileCreator >> createJavaFileForClass: aClass [

	|  fileRef |
	self createEndpointDirectory.
	fileRef := self createJavaFileFileRef: aClass.
	
	fileRef writeStreamDo: [ :aStream | (javaFileWrapper generateClass: aClass) printOn: aStream ].
	
]

{ #category : 'as yet unclassified' }
JavaWrapperFileCreator >> createTheFileInTheProject: aClass [


defaultDestinationDirectory := home / 'eclipse-workspaces' / 'gemoc-workspace' / 'Gemoc-connection-handler' / 'src' / 'main' / 'java' / 'gemocServer' / 'metamodelElementWrapper' / 'generatedWrapper'.

self createJavaFileForClass: aClass.
]

{ #category : 'accessing' }
JavaWrapperFileCreator >> defaultDestinationDirectory [

	^ defaultDestinationDirectory
]

{ #category : 'accessing' }
JavaWrapperFileCreator >> defaultDestinationDirectory: aFileLocator [

	defaultDestinationDirectory := aFileLocator
]

{ #category : 'as yet unclassified' }
JavaWrapperFileCreator >> getCompleteDirPath [ 

 ^ (defaultDestinationDirectory / outPutFolderName).
]

{ #category : 'initialization' }
JavaWrapperFileCreator >> initialize [ 

home := FileLocator home.
javaFileWrapper := JavaWrappedClassGenerator new.
defaultDestinationDirectory := home.
outPutFolderName := 'generateJavaFileDirectory'.
]

{ #category : 'accessing' }
JavaWrapperFileCreator >> outPutFolderName [

	^ outPutFolderName
]

{ #category : 'accessing' }
JavaWrapperFileCreator >> outPutFolderName: aString [

	outPutFolderName := aString
]
