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
		'programTypes'
	],
	#classVars : [
		'Trace'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'accessing' }
GemocTrace class >> current [

	^ Trace
]

{ #category : 'accessing' }
GemocTrace class >> source: anAbsolutePathString [

	^ Trace := self new source: anAbsolutePathString
]

{ #category : 'private - building' }
GemocTrace >> build [

	self flattenSteps.
	self buildSteps.
	self buildProgramMetaModel
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
				 programTypes at: est __name__ asNativeObject ]) ]
]

{ #category : 'private - building' }
GemocTrace >> buildSteps [

	gemocSteps := flattenedSteps collect: [ :s | 
		              GemocProgramState fromGemocStep: s ]
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

{ #category : 'private - building' }
GemocTrace >> flattenStep: s [

	| substeps |
	substeps := [ s subSteps ]
		            on: Error
		            do: [ :e | 
			            e crTrace.
			            #(  ) ].
	(substeps asNativeDict at: #kind) = 'exception' ifFalse: [ 
		substeps do: [ :subs | self flattenStep: subs ] ].
	flattenedSteps add: s
]

{ #category : 'private - building' }
GemocTrace >> flattenSteps [

	"We flatten the trace to obtain an ordered list of steps and substeps.
	The order of the steps is the execution order.
	The step granularity and the number of steps depends on the DSL."
	
	flattenedSteps := OrderedCollection new.
	steps do: [ :s | self flattenStep: s step]
]

{ #category : 'accessing' }
GemocTrace >> flattenedSteps [

	^ flattenedSteps
]

{ #category : 'accessing' }
GemocTrace >> flattenedSteps: anObject [

	flattenedSteps := anObject
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
