Class {
	#name : 'JavaClass',
	#superclass : 'Object',
	#instVars : [
		'name',
		'attributes',
		'constructor',
		'methods'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'as yet unclassified' }
JavaClass class >> createClassWithName: aName [

	^ self new
		  name: aName;
		  yourself
]

{ #category : 'adding' }
JavaClass >> addAttribute: anAttribute [

	attributes add: anAttribute
]

{ #category : 'adding' }
JavaClass >> addMethod: aMethod [

	methods add: aMethod
]

{ #category : 'accessing' }
JavaClass >> attributes [

	^ attributes
]

{ #category : 'accessing' }
JavaClass >> attributes: anObject [

	attributes := anObject
]

{ #category : 'accessing' }
JavaClass >> constructor [

	^ constructor
]

{ #category : 'accessing' }
JavaClass >> constructor: anObject [

	constructor := anObject
]

{ #category : 'initialization' }
JavaClass >> initialize [

	methods := OrderedCollection new.
	attributes := OrderedCollection new
]

{ #category : 'accessing' }
JavaClass >> methods [

	^ methods
]

{ #category : 'accessing' }
JavaClass >> methods: anObject [

	methods := anObject
]

{ #category : 'accessing' }
JavaClass >> name [

	^ name
]

{ #category : 'accessing' }
JavaClass >> name: anObject [

	name := anObject
]

{ #category : 'printing' }
JavaClass >> printOn: aStream [

	aStream << ('class {1}\{' format: { name }).
	aStream
		cr;
		cr.

	attributes do: [ :att | att printOn: aStream ].

	constructor printOn: aStream.

	methods do: [ :met | met printOn: aStream ].

	aStream << '\}'
]
