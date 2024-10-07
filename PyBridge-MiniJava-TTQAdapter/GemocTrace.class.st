Class {
	#name : 'GemocTrace',
	#superclass : 'Object',
	#instVars : [
		'steps',
		'flattenedSteps',
		'gemocSteps',
		'trace',
		'path'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter',
	#package : 'PyBridge-MiniJava-TTQAdapter'
}

{ #category : 'accessing' }
GemocTrace class >> source: anAbsolutePathString [
	^self new source: anAbsolutePathString
	
]

{ #category : 'accessing' }
GemocTrace class >> steps: aCollection [

	^ self new
		  steps: aCollection;
		  build;
		  yourself
]

{ #category : 'private - building' }
GemocTrace >> build [

	self flattenSteps.
	self buildSteps
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
