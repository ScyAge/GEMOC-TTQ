Class {
	#name : #GemocMetaModelGenerator,
	#superclass : #Object,
	#category : #'Gemoc-MetaModel-Generator'
}

{ #category : #'as yet unclassified' }
GemocMetaModelGenerator class >> ensureCreatePackage: pName [

	(RPackage organizer includesPackageNamed: pName asSymbol) ifTrue: [ 
		^ self ].
	RPackage organizer createPackageNamed: pName
]

{ #category : #'as yet unclassified' }
GemocMetaModelGenerator class >> generateLanguageSyntaxMetaModel: metamodel [

	|metaModelDict classesDescriptions languageName generatedClasses|
	metaModelDict :=  metamodel __dict__ asNativeDict.
	classesDescriptions := (metaModelDict associations select:[:association| 
	 |className|
	className := association key.
	(className first isUppercase) and:[(className = 'AccessLevel') not]]). 
	languageName := (metaModelDict at: 'nsPrefix') _value asNativeObject capitalized.
	
	self ensureCreatePackage: languageName.
	
	generatedClasses := OrderedCollection new.
	[generatedClasses includesAll: metaModelDict keys] whileFalse: [ 
		|classesToGenerate| classesToGenerate := 
		(classesDescriptions select:[:association| generatedClasses includesAll: association value eSuperTypes asNativeList]) asDictionary.
		classesToGenerate keysAndValuesDo: [:className :classDef|
			|fullClassName superTypes superClass|
			fullClassName := languageName, className.
	
			superTypes := classDef eSuperTypes asNativeList.
			superClass :=  superTypes isEmpty ifTrue:[Object] ifFalse:[Smalltalk at: superTypes first asSymbol].
			
			superClass subclass: fullClassName asSymbol
							instanceVariableNames: 'executionStep programState'
							classVariableNames: ''
							package: languageName.
			
			generatedClasses add: className.
			
			]
	
	
	 ]
]
