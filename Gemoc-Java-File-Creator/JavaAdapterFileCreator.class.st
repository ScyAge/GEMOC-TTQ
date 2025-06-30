Class {
	#name : 'JavaAdapterFileCreator',
	#superclass : 'JavaFileCreator',
	#category : 'Gemoc-Java-File-Creator',
	#package : 'Gemoc-Java-File-Creator'
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
