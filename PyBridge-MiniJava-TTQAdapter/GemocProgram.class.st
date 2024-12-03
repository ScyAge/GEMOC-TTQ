Class {
	#name : 'GemocProgram',
	#superclass : 'GemocProgramState',
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'building' }
GemocProgram >> build [
	"self halt"
]

{ #category : 'accessing' }
GemocProgram >> container [
	^executionStep _container
]
