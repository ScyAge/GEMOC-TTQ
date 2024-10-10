Class {
	#name : 'GemocBlock',
	#superclass : 'GemocProgramState',
	#instVars : [
		'statements'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'building' }
GemocBlock >> build [
	statements := programState statements asNativeList
]
