Class {
	#name : 'AbstractJavaClassGenerator',
	#superclass : 'Object',
	#category : 'Gemoc-Java-File-Creator',
	#package : 'Gemoc-Java-File-Creator'
}

{ #category : 'testing' }
AbstractJavaClassGenerator class >> isAbstract [

	^ self == AbstractJavaClassGenerator
]

{ #category : 'building' }
AbstractJavaClassGenerator >> generateClass: aMetaModelElement [

	self subclassResponsibility.
]

{ #category : 'as yet unclassified' }
AbstractJavaClassGenerator >> generateTrueClassName: aMetaModelElement [

	^ (aMetaModelElement name withoutPrefix: 'Gemoc') , 'Impl'
]

{ #category : 'as yet unclassified' }
AbstractJavaClassGenerator >> getInstanceVariableFromAMetaModelElement: aMetaModelElement [

	^ aMetaModelElement slots collect: [ :slot | slot name ]
]
