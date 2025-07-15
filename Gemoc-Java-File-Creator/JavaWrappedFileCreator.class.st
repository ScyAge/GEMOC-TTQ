Class {
	#name : 'JavaWrappedFileCreator',
	#superclass : 'JavaFileCreatorForClass',
	#category : 'Gemoc-Java-File-Creator-fileCreator',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'fileCreator'
}

{ #category : 'hooks' }
JavaWrappedFileCreator >> getFileName: aClass [

	^ (javaFileWrapper generateTrueClassName: aClass) , 'Wrapper'
	  , '.java'
]

{ #category : 'hooks' }
JavaWrappedFileCreator >> getJavaClassGenerator [

	^ JavaWrappedClassGenerator new.
]

{ #category : 'hooks' }
JavaWrappedFileCreator >> getOutputFolderName [

	^ 'generatedWrapper'.
]
