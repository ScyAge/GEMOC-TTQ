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
		             ((self generateTrueClassName: aMetaModelElement),'Wrapper').


	self
		generateImportAndPackageOn: generator onElement: aMetaModelElement ;
		generateInstanceVaribleOnClass: generator
		onElement: aMetaModelElement;
		generateStubOnClasseGen: generator onElement: aMetaModelElement;
		generateStubForWrappedAttributeOnClasseGen: generator onElement:aMetaModelElement;
		generateImplementorOnAJavaClassGenerator: generator.
		
	
		^ generator 
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateGetterForInstanceVarible: name [

	^ JavaMethod
		  createAjavaMethodWithVisibility: 'public'
		  withReturnType: 'String'
		  withParameter: JavaListOfElement new
		  withBody: ('return {1}Generated;' format: { name })
		  withName: ('get{1}' format: { name })
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateImplementorOnAJavaClassGenerator: aGenerator [

	| listParam |
	aGenerator addImplementedInterface:
		(JavaType createJavaType: 'MetamodelElementWrapper').

	listParam := JavaListOfElement new.
	listParam addAnElement: (JavaParameter
			 createAParameterWithName: 'visitor'
			 withType: (JavaType createJavaType: 'MetamodelElementWrapperReaderVisitor')).
	
	aGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: 'String'
			 withParameter: listParam
			 withBody: 'return visitor.visit(this);'
			 withName: 'accept')
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateImportAndPackageOn: aGenerator onElement: aMetaModelElement [

	aGenerator
		addImport: (JavaType createJavaType:
					 'main.java.gemocServer.metamodelElementWrapper.MetamodelElementWrapper');
		addImport: (JavaType createJavaType:
					 'main.java.gemocServer.runtimeStepReader.MetamodelElementWrapperReaderVisitor');
		addImport: (JavaType createJavaType:
					 ('org.tetrabox.minijava.model.miniJava.impl.{1}' format:
							  { (self generateTrueClassName: aMetaModelElement) }));
		package:
			'main.java.gemocServer.metamodelElementWrapper.generatedWrapper'
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateInstanceVaribleOnClass: classGen onElement: aMetaModelElement [

	(self getInstanceVariableFromAMetaModelElement: aMetaModelElement)
		do: [ :att |
			classGen addAttribute: (JavaAttribute
					 createAttributeWithName: (att, 'Generated')
					 withVisibility: 'private'
					 withType: 'String') ].
	
	classGen addAttribute: (JavaAttribute
					 createAttributeWithName: ((self generateTrueClassName: aMetaModelElement) asLowercase )
					 withVisibility: 'private'
					 withType: (self generateTrueClassName: aMetaModelElement))
				
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateSetterForInstanceVarible: name [

| listParam |

listParam := JavaListOfElement new.

listParam addAnElement: (JavaParameter createAParameterWithName: 'value' withType: 'String' ).

	^ JavaMethod
		  createAjavaMethodWithVisibility: 'public'
		  withReturnType: 'void'
		  withParameter: listParam
		  withBody: ('{1}Generated = value;' format: { name })
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
