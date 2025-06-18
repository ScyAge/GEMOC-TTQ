Class {
	#name : 'JavaClass',
	#superclass : 'Object',
	#instVars : [
		'name',
		'attributes',
		'constructor',
		'methods',
		'implementor',
		'extender',
		'imports',
		'package'
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
JavaClass >> addConstructor: aJavaConstructor [

	constructor add: aJavaConstructor
]

{ #category : 'adding' }
JavaClass >> addImplementedInterface: typeOfTheInterface [

	implementor addAnElement: typeOfTheInterface
]

{ #category : 'adding' }
JavaClass >> addImport: anImportJavaType [

	imports addAnElement: anImportJavaType
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

{ #category : 'initialization' }
JavaClass >> initialize [

	methods := OrderedCollection new.
	attributes := OrderedCollection new.
	constructor := OrderedCollection new.
	implementor := JavaListOfImplementedInterface new.
	imports := JavaListOfImport new.
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

{ #category : 'accessing' }
JavaClass >> package: anObject [

	package := anObject
]

{ #category : 'printing' }
JavaClass >> printClassBodyOn: aStream [

	aStream
		<< '{';
		cr;
		cr.
	attributes do: [ :att | att printOn: aStream ].
	constructor isEmpty ifFalse: [ constructor printOn: aStream ].
	methods do: [ :met | met printOn: aStream ].
	aStream << '}'
]

{ #category : 'printing' }
JavaClass >> printClassHeaderOn: aStream [

	aStream << ('class {1} ' format: { name }).
	extender ifNotNil: [
		aStream << 'extends '.
		extender printOn: aStream ].
	
	implementor isEmpty ifFalse: [ implementor printOn: aStream ].
]

{ #category : 'printing' }
JavaClass >> printImportAndPackageDeclaration: aStream [

	package ifNotNil: [
		aStream
			<< ('package {1};' format: { package });
			cr ].
	imports isEmpty ifFalse: [ imports printOn: aStream ].

	aStream cr
]

{ #category : 'printing' }
JavaClass >> printOn: aStream [

	
	self printImportAndPackageDeclaration: aStream.
	
	self printClassHeaderOn: aStream.
	
	self printClassBodyOn: aStream.
]
