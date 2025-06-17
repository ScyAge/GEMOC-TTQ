Class {
	#name : 'JavaClassGenerator',
	#superclass : 'Object',
	#category : 'Gemoc-Java-File-Creator',
	#package : 'Gemoc-Java-File-Creator'
}

{ #category : 'as yet unclassified' }
JavaClassGenerator >> generateInstanceVaribleWithName: varName WithVisibility: visibility WithType: aType [

^ '{1} {2} {3};' format: { visibility . aType . varName }
]

{ #category : 'as yet unclassified' }
JavaClassGenerator >> generateMethodTextWithReturnType: aType withName: aName withParam: param withBody: aBody withVisibility: vis [

^ '{1} {2} {3}({4})\{
	{5}
\}' format: { vis . aType . aName . param . aBody }
]
