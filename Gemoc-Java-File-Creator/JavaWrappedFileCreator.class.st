Class {
	#name : 'JavaWrappedFileCreator',
	#superclass : 'JavaFileCreator',
	#category : 'Gemoc-Java-File-Creator',
	#package : 'Gemoc-Java-File-Creator'
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
