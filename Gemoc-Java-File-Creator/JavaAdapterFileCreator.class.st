Class {
	#name : 'JavaAdapterFileCreator',
	#superclass : 'JavaFileCreatorForClass',
	#category : 'Gemoc-Java-File-Creator-fileCreator',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'fileCreator'
}

{ #category : 'hooks' }
JavaAdapterFileCreator >> getFileName: aClass [

	^ (javaFileWrapper generateTrueClassName: aClass) , 'Adapter'
	  , '.java'
]

{ #category : 'hooks' }
JavaAdapterFileCreator >> getJavaClassGenerator [

	^ JavaAdapterClassGenerator new.
]

{ #category : 'hooks' }
JavaAdapterFileCreator >> getOutputFolderName [

	^ 'generatedAdapter'
]
