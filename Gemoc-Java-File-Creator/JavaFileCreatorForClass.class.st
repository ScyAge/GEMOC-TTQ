Class {
	#name : 'JavaFileCreatorForClass',
	#superclass : 'JavaFileCreator',
	#category : 'Gemoc-Java-File-Creator-fileCreator',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'fileCreator'
}

{ #category : 'testing' }
JavaFileCreatorForClass class >> isAbstract [

	^ self == JavaFileCreatorForClass
]

{ #category : 'hooks' }
JavaFileCreatorForClass >> generateContent: anObject [

	^ (javaFileWrapper generateClass: anObject)
]
