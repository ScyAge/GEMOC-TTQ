Class {
	#name : #GemocBlock,
	#superclass : #GemocProgramState,
	#instVars : [
		'statements'
	],
	#category : #'PyBridge-MiniJava-TTQAdapter'
}

{ #category : #building }
GemocBlock >> build [
	statements := programState statements asNativeList
]
