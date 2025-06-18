Class {
	#name : 'JavaListOfImplementedInterface',
	#superclass : 'JavaListOfElement',
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'printing' }
JavaListOfImplementedInterface >> printOn: aStream [

aStream << 'implements '.

super printOn: aStream.
]
