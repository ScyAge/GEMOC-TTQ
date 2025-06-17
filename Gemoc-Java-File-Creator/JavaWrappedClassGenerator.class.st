Class {
	#name : 'JavaWrappedClassGenerator',
	#superclass : 'Object',
	#category : 'Gemoc-Java-File-Creator',
	#package : 'Gemoc-Java-File-Creator'
}

{ #category : 'building' }
JavaWrappedClassGenerator >> generateClass: aMetaModelElement [

	| generator |
	generator := JavaClass createClassWithName:
		             (self generateTrueClassName: aMetaModelElement).


	self
		generateInstanceVaribleOnClass: generator
		onElement: aMetaModelElement;
		generateStubOnClasseGen: generator onElement: aMetaModelElement;
		generateStubForWrappedAttributeOnClasseGen: generator onElement:aMetaModelElement. 
		
	
		^ generator 
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateGetterForInstanceVarible: name [

	^ JavaMethod
		  createAjavaMethodWithVisibility: 'public'
		  withReturnType: 'String'
		  withParameter: JavaListOfElement new
		  withBody: ('return {1};' format: { name })
		  withName: ('get{1}' format: { name })
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateInstanceVaribleOnClass: classGen onElement: aMetaModelElement [

	(self getInstanceVariableFromAMetaModelElement: aMetaModelElement)
		do: [ :att |
			classGen addAttribute: (JavaAttribute
					 createAttributeWithName: att
					 withVisibility: 'private'
					 withType: 'String') ].
	
	classGen addAttribute: (JavaAttribute
					 createAttributeWithName: ((self generateTrueClassName: aMetaModelElement) asLowercase )
					 withVisibility: 'private'
					 withType: 'String')
				
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateSetterForInstanceVarible: name [

| listParam |

listParam := JavaListOfElement new.

listParam addAnElement: (JavaParameter createAParameterWithName: 'name' withType: 'String' ).

	^ JavaMethod
		  createAjavaMethodWithVisibility: 'public'
		  withReturnType: 'void'
		  withParameter: listParam
		  withBody: ('return {1};' format: { name })
		  withName: ('set{1}' format: { name })
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateStubForWrappedAttributeOnClasseGen: classGenerator onElement: aMetaModelElement [

	| listParam name |
	name := self generateTrueClassName: aMetaModelElement.

	listParam := JavaListOfElement new.
	listParam addAnElement:
		(JavaParameter createAParameterWithName: 'value' withType: name).

	classGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: 'void'
			 withParameter: listParam
			 withBody: ('{1} = value;' format: { name asLowercase })
			 withName: ('set{1}' format: { name })).



	classGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: name
			 withParameter: JavaListOfElement new
			 withBody: ('return {1};' format: { name asLowercase })
			 withName: ('get{1}' format: { name }))
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateStubOnClasseGen: classGenerator onElement: aMetaModelElement [

(self getInstanceVariableFromAMetaModelElement: aMetaModelElement) do: [ :el |
	classGenerator addMethod: (self generateGetterForInstanceVarible: el).
	classGenerator addMethod: (self generateSetterForInstanceVarible: el).
	 ].


]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateTrueClassName: aMetaModelElement [

	^ (aMetaModelElement name withoutPrefix: 'Gemoc') , 'Impl'
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> getInstanceVariableFromAMetaModelElement: aMetaModelElement [

	^ aMetaModelElement slots collect: [ :slot | slot name ]
]
