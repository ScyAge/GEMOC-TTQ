Class {
	#name : 'JavaType',
	#superclass : 'Object',
	#instVars : [
		'typeName'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'as yet unclassified' }
JavaType class >> createJavaType: aStringType [

	^ self new
		  typeName: aStringType;
		  yourself
]

{ #category : 'printing' }
JavaType >> printOn: aStream [

aStream << typeName
]

{ #category : 'accessing' }
JavaType >> typeName [

	^ typeName
]

{ #category : 'accessing' }
JavaType >> typeName: anObject [

	typeName := anObject
]
