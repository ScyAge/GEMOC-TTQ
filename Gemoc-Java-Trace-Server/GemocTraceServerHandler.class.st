"
this class handle the connection with the Gemoc server in java, 

you can create the object with the class side method withUrl:  and put the server URL

if you want to get the Trace of the program use the method getTrace, you will get a dictionnary with as key number between 0 and the number of element in the dict.
"
Class {
	#name : 'GemocTraceServerHandler',
	#superclass : 'Object',
	#instVars : [
		'client',
		'hostURL'
	],
	#category : 'Gemoc-Java-Trace-Server-server',
	#package : 'Gemoc-Java-Trace-Server',
	#tag : 'server'
}

{ #category : 'as yet unclassified' }
GemocTraceServerHandler class >> withUrl: anUrl [
"url without route "

^ self new hostURL: anUrl ; yourself.
]

{ #category : 'as yet unclassified' }
GemocTraceServerHandler >> getDefault [ 

^ client get: (hostURL , '/').
]

{ #category : 'as yet unclassified' }
GemocTraceServerHandler >> getFetchAllAvailableTrace [

 ^ STONJSON fromString: (client get: (hostURL , '/fetchAllAvailableTrace'))
]

{ #category : 'as yet unclassified' }
GemocTraceServerHandler >> getTrace [ 

^  STONJSON fromString: (client get: (hostURL , '/runTime')).
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
