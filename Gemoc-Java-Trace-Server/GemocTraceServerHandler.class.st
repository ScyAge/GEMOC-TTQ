Class {
	#name : 'GemocTraceServerHandler',
	#superclass : 'Object',
	#instVars : [
		'client',
		'hostURL'
	],
	#category : 'Gemoc-Java-Trace-Server',
	#package : 'Gemoc-Java-Trace-Server'
}

{ #category : 'as yet unclassified' }
GemocTraceServerHandler class >> withUrl: anUrl [
"url without route "

^ self new hostURL: anUrl ; yourself.
]

{ #category : 'as yet unclassified' }
GemocTraceServerHandler >> getAllTrace [

^ STONJSON fromString: (client get: (hostURL , '/allTrace')).

]

{ #category : 'as yet unclassified' }
GemocTraceServerHandler >> getDefault [ 

^ client get: (hostURL , '/').
]

{ #category : 'as yet unclassified' }
GemocTraceServerHandler >> getRuntime [ 

^ STONJSON fromString: (client get: (hostURL , '/runTime')).
]

{ #category : 'as yet unclassified' }
GemocTraceServerHandler >> getStep [ 

^ client get: (hostURL , '/step').
]

{ #category : 'accessing' }
GemocTraceServerHandler >> hostURL [

	^ hostURL
]

{ #category : 'accessing' }
GemocTraceServerHandler >> hostURL: anObject [

	hostURL := anObject
]

{ #category : 'initialization' }
GemocTraceServerHandler >> initialize [ 

client := ZnClient new.
]
