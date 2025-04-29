Class {
	#name : 'GemocTrace',
	#superclass : 'Object',
	#instVars : [
		'steps',
		'flattenedSteps',
		'gemocSteps',
		'trace',
		'path',
		'metaModelTrace',
		'programMetaModel',
		'programTypes',
		'executionTree',
		'executionSteps',
		'isProgramMetaModelGenereted'
	],
	#classVars : [
		'Trace'
	],
	#classInstVars : [
		'errors'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'accessing' }
GemocTrace class >> current [

	^ Trace
]

{ #category : 'error handling' }
GemocTrace class >> errors [ 

	^errors ifNil: [ errors := OrderedCollection new ]
]

{ #category : 'error handling' }
GemocTrace class >> logError: anErrorString [
	self errors add: anErrorString
]

{ #category : 'accessing' }
GemocTrace class >> source: anAbsolutePathString [
	
	errors := OrderedCollection new.
	^ Trace := self new source: anAbsolutePathString
]

{ #category : 'private - accessing' }
GemocTrace class >> traitedTypes [
	^{'Assignee' -> TGemocAssignee}
]

{ #category : 'private - accessing' }
GemocTrace class >> typeNamed: aString [

	^ self current
		  ifNil: [ GemocUnknownType ]
		  ifNotNil: [ :trace | trace typeNamed: aString ]
]

{ #category : 'private - building' }
GemocTrace >> build [

	self flattenSteps.
	isProgramMetaModelGenereted ifFalse: [ 
		self buildProgramMetaModel. 
		isProgramMetaModelGenereted := true].
	self buildSteps.
]

{ #category : 'api' }
GemocTrace >> buildExecutionTree [

	executionSteps := OrderedCollection new.
	executionTree := Dictionary new.
	gemocSteps do: [ :step |
		| execStep |
		step pc = -1 ifFalse: [
			| execId modelId programStateId |
			execStep := GemocExecutionStep on: step.
			execStep build.
			executionSteps add: execStep.

			executionTree
				at: ([ step container uuid ]
						 on: Error
						 do: [ step model uuid ])
				ifPresent: [ :e | e addChild: execStep ].
			execId := [ execStep gemocStep executionStep uuid ]
				          on: Error
				          do: [ execStep id ].
			modelId := [ execStep gemocStep model uuid ]
				           on: Error
				           do: [ execStep id ].
			programStateId := [ execStep gemocStep programState uuid ]
				                  on: Error
				                  do: [ execStep id ].
			executionTree at: execId put: execStep.
			executionTree at: modelId put: execStep.
			executionTree at: programStateId put: execStep ] ]
]

{ #category : 'private - building' }
GemocTrace >> buildProgramMetaModel [

	| metaModelDict languageName typesModel |
	programTypes := Dictionary new.
	metaModelDict := programMetaModel __dict__ asNativeDict.
	languageName := (metaModelDict at: 'nsPrefix') _value asNativeObject
		                capitalized.

	typesModel := (metaModelDict associations select: [ :association |
		               | className |
		               className := association key.
		               className first isUppercase and: [
			               (className = 'AccessLevel') not ] ]) asDictionary.

	"Pass 1: generating all types"
	typesModel keysAndValuesDo: [ :typeName :typeModel |
		| gemocType |
		gemocType := GemocType new.
		gemocType typeName: typeName.
		gemocType model: typeModel.
		programTypes at: typeName put: gemocType ].

	"Pass 2: setting super types"
	typesModel keysAndValuesDo: [ :typeName :typeModel |
		| gemocType |
		gemocType := programTypes at: typeName.
		gemocType superTypes:
			(gemocType model eSuperTypes asNativeList collect: [ :est |
				 programTypes at: est __name__ asNativeObject ]) ].

	self generateTypesClasses
]

{ #category : 'api' }
GemocTrace >> buildSteps [

	gemocSteps := (flattenedSteps collect: [ :s |
		               [ GemocProgramState fromGemocStep: s ]
			               on: Error
			               do: [ :err |
				               self class logError:
					               'Build step error:' , err printString.
				               nil ] ]) reject: #isNil.
	gemocSteps do: #build.

	"not optimal, but we do another pass over all steps to build the execution tree"
	self buildExecutionTree
]

{ #category : 'pybridge' }
GemocTrace >> connectToBridge [
	PyBridge restart.
	trace := PyBridge load: 'gemoctrace::loader'.
	steps := trace load_steps: path.
	metaModelTrace := trace trace_mm.
	programMetaModel := trace javamm.
	self build
]

{ #category : 'accessing' }
GemocTrace >> executionTree [
	^executionTree
]

{ #category : 'private - building' }
GemocTrace >> flattenStep: s [

	| substeps |
	substeps := [ s subSteps ]
		            on: Error
		            do: [ :err |
			            self class logError: ('Substeps error: ', err printString).
			            #(  ) ].
	(substeps asNativeDict at: #kind) = 'exception' ifFalse: [
		substeps do: [ :subs | self flattenStep: subs ] ].
	s isPythonError ifFalse: [ flattenedSteps add: s ]
]

{ #category : 'private - building' }
GemocTrace >> flattenSteps [
	"We flatten the trace to obtain an ordered list of steps and substeps.
	The order of the steps is the execution order.
	The step granularity and the number of steps depends on the DSL."

	flattenedSteps := OrderedCollection new.

	true ifTrue: [
		flattenedSteps := steps asNativeList collect: [ :s |
			                  [ s step ]
				                  on: Error
				                  do: [ :err |
					                  self class logError:
						                  'Flatten step error:' , err printString.
					                  nil ] ].
		flattenedSteps := flattenedSteps reject: [ :e |
			                  e isNil or: [ e isPythonError ] ].
		self assert: (flattenedSteps noneSatisfy: #isNil).
		self assert: (flattenedSteps noneSatisfy: #isPythonError).
		^ self ].
	steps do: [ :s | self flattenStep: s step ]
]

{ #category : 'accessing' }
GemocTrace >> flattenedSteps [

	^ flattenedSteps
]

{ #category : 'accessing' }
GemocTrace >> flattenedSteps: anObject [

	flattenedSteps := anObject
]

{ #category : 'accessing' }
GemocTrace >> gemocSteps [

	^ gemocSteps
]

{ #category : 'private - building' }
GemocTrace >> generateClass: aSymbol superClass: aClass traits: anArray [

	^ Smalltalk at: aSymbol ifAbsent: [
		  ((aClass << aSymbol)
			   traits: anArray;
			   tag: 'generated';
			   package: self class package name) install ]
]

{ #category : 'private - building' }
GemocTrace >> generateTypesClasses [

	| remainingTypes traits |
	(programTypes values select: [ :type | type superTypes isEmpty ])
		do: [ :type |
			| className class |
			className := ('Gemoc' , type typeName) asSymbol.
			traits := (self class traitedTypes select: [ :tt |
				           tt key = type typeName ]) collect: #value.
			class := self
				         generateClass: className
				         superClass: GemocType
				         traits: traits.
			type typeClass: class ].

	remainingTypes := (programTypes values select: [ :type | type superTypes notEmpty ])
		                  																			asOrderedCollection.

	[ remainingTypes isEmpty ] whileFalse: [
		remainingTypes do: [ :type |
			| className superClassName class |
			className := ('Gemoc' , type typeName) asSymbol.
			superClassName := ('Gemoc' , type superTypes first typeName)
				                  asSymbol.
			Smalltalk at: superClassName ifPresent: [ :superClass |
				traits := (self class traitedTypes select: [ :tt |
					           type superTypes anySatisfy: [ :st |
						           st typeName = tt key ] ]) collect: #value.
				class := self
					         generateClass: className
					         superClass: superClass
					         traits: traits ].
			type typeClass: class ].

		remainingTypes := remainingTypes select: [ :type |
			                  type typeClass isNil ] ]
]

{ #category : 'initialization' }
GemocTrace >> initialize [ 	
	flattenedSteps := OrderedCollection new
]

{ #category : 'initialization' }
GemocTrace >> source: anAbsolutePathString [
	path := anAbsolutePathString.
	self connectToBridge 
]

{ #category : 'accessing' }
GemocTrace >> steps [

	^ steps
]

{ #category : 'accessing' }
GemocTrace >> steps: anObject [

	steps := anObject
]

{ #category : 'private - accessing' }
GemocTrace >> typeNamed: aString [

	^ programTypes at: aString ifAbsent: [ GemocUnknownType ]
]
