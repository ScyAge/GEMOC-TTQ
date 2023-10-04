Class {
	#name : #GemocTrace,
	#superclass : #Object,
	#instVars : [
		'steps',
		'flattenedSteps',
		'gemocSteps'
	],
	#category : #'PyBridge-MiniJava-TTQAdapter'
}

{ #category : #accessing }
GemocTrace class >> steps: aCollection [
	^self new steps: aCollection
]

{ #category : #api }
GemocTrace >> buildSteps [

	gemocSteps := flattenedSteps collect: [ :s | 
		              GemocProgramState fromGemocStep: s ]
]

{ #category : #api }
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

{ #category : #api }
GemocTrace >> flattenSteps [

	"We flatten the trace to obtain an ordered list of steps and substeps.
	The order of the steps is the execution order.
	The step granularity and the number of steps depends on the DSL."
	
	flattenedSteps := OrderedCollection new.
	steps do: [ :s | self flattenStep: s step]
]

{ #category : #accessing }
GemocTrace >> flattenedSteps [

	^ flattenedSteps
]

{ #category : #accessing }
GemocTrace >> flattenedSteps: anObject [

	flattenedSteps := anObject
]

{ #category : #accessing }
GemocTrace >> initialize [ 	
	flattenedSteps := OrderedCollection new
]

{ #category : #accessing }
GemocTrace >> steps [

	^ steps
]

{ #category : #accessing }
GemocTrace >> steps: anObject [

	steps := anObject
]
