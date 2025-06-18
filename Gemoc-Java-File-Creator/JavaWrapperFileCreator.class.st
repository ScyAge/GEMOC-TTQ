"
This class creates .java file with Java code in it


createJavaFileForClass: method for creating a java file for the class you specified the code in the file is generated with the JavaWrapperClassGenerator

The .java file is created in the generateWrapper which is in your user directory by default but you can modify it by seting a new path in defaultDestinationDirectory instance variable


Example: 

JavaWrapperFileCreator new createJavaFileForClass: GemocTraceServerHandler





"
Class {
	#name : 'JavaWrapperFileCreator',
	#superclass : 'Object',
	#instVars : [
		'home',
		'javaFileWrapper',
		'defaultDestinationDirectory'
	],
	#category : 'Gemoc-Java-File-Creator',
	#package : 'Gemoc-Java-File-Creator'
}

{ #category : 'as yet unclassified' }
JavaWrapperFileCreator >> createEndpointDirectory [


defaultDestinationDirectory isDirectory ifFalse: [ defaultDestinationDirectory ensureCreateDirectory ].
]

{ #category : 'as yet unclassified' }
JavaWrapperFileCreator >> createJavaFileFileRef: aClass [

	| name fileRef |
	name := aClass name.

	fileRef := (defaultDestinationDirectory
	            /
	            ((javaFileWrapper generateTrueClassName:
		             aClass ), 'Wrapper' , '.java')) asFileReference.

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
JavaWrapperFileCreator >> defaultDestinationDirectory: anObject [

	defaultDestinationDirectory := anObject
]

{ #category : 'initialization' }
JavaWrapperFileCreator >> initialize [ 

home := FileLocator home.
javaFileWrapper := JavaWrappedClassGenerator new.
defaultDestinationDirectory := home /'generateJavaFileDirectory'
]
