## setup

BaseLine 
```st
Metacello new	
	baseline: 'GEMOCTTQ';	
	repository: 'github://ScyAge/GEMOC-TTQ';	
	load
```

To be able to use the TTQ, you must also import the baseline of the debbugger seeker 

```st
Metacello new
    baseline: 'Seeker';
    repository: 'github://maxwills/SeekerDebugger:main';
    load.
```

then at the top of the screen do Pharo>Settings>>Tools>Debugging>Debugger Extensions> Seeker> untick show in debugger

## Goal

To start this project goes hand in hand with https://github.com/ScyAge/GemocTTQ. This project aims to simplify the use of TTQ in Pharo for any user. This project targets two types of people: DSL creators in GEMOC and users who want to use your TTQs for their DSLs.

The two following subparties imply that the creator and the user is plugged in to https://github.com/ScyAge/GemocTTQ on their DSLs

For the creators of DSL: 

We offer the MMEWC which is an inteface that will allow a design of DSL to create wrappers of elements of his meta model that he will choose where to place in his GEMOC project. The designer will have to import into Pharo the AST / Meta-model of his DSL with the server in GEMOC. For this, an instance of the GemocServerHandler class is the route `getAST` should be used in Pharo.


For users: 

The user via an instance of the GemocServerHandler class with the `setTrace` method will choose the trace on which he wants to perform TTQs. 
With the method `getTrace` the user will be able to retrieve the trace that he has loaded and parsed, and of which only the elements with existing wrappers will be present in the dictionary he retrieves.

Subsequently, this information is used in DynamicTTQCreatorPresenter to be able to create selection functions on the available elements and apply them on the trace in order to perform TTQs.

<img width="951" height="951" alt="diagramServerRoute drawio" src="https://github.com/user-attachments/assets/32297f24-763b-4e7f-9f27-31d225f0ddf2" />


## Current state of progress

For the creators of dsl: 

the MMEWC interface only allows to create wrappers for minijava DSL of which a representation exists in hard in pharo.

For users:

A user can only retrieve an already existing minijava trace. 
In this trace only the case of method calls for minijava are present, and in Pharo there is only one adapter for methodCall in order to be able to perform selection functions.


<img width="629" height="413" alt="image" src="https://github.com/user-attachments/assets/15c10fad-c8c0-4c8a-ba0f-56f1fb056178" />

- the user can use TraceLoaderUI and connect it to the servrer with ip of the server. After specifying the IP, it can retrieve all the trace names present in the traceContainer folder of the server using the "fetch all trace" button. After selecting a trace, it must first do "set Trace" in order to notify the server which trace it wants to be able to get. Once the server has sent the response, he can do "get trace" and retrieve a dictionary with the trace parsed inside

<img width="753" height="872" alt="image" src="https://github.com/user-attachments/assets/ddab8b12-f571-4662-8ed8-2b27c468ae6a" />

this sceenshot shows the creation of a TTQ on method calls whose method is called bubblesort, which uses the dictionary received from the server and the adapter.

## next realization 

For the creators of dsl: 

- be able to retrieve the AST of any DSL and fill the list of choices with each of its elements and be able to create wrappers based on the element of this AST

For users:

- reutiliser le TraceLoader afin de l'adapter au server Gemoc, avec les routes `setTrace` et `getTrace`
- adapt the DynamicTTQCreatorPresenter so that after loading the trace, we can create selection functions only on elements of the trace that have been retrieved, and that after creating the selection functions, we can apply them to the trace 

 ## How to make the exp again


- clone for GEMOC https://github.com/ScyAge/GemocTTQ/tree/add-server-route et allé sur la branche add server route

- clone for Pharo https://github.com/ScyAge/GEMOC-TTQ/tree/traceLoaderChange et allé sur la branche traceLoaderChange (Baseline)



GEMOC

- verify the dependencies in the classpath of the simpletrace and minijava modules
- check the precency of libraries for the server in the project’s METAINF (runtime/classpath tab) and in the Java buildpath (libraries/classpath tab)
- launch the server in the test folder, With the LaunchServerTest class

Pharo 

- once the baseline is loaded, in a playgroup do: 


```st
|app loader |

app := DynamicTTQCreatorApp new.


loader := DynamicTTQCreatorPresenter newApplication: app model: (DynamicTTQCreator new).


loader open.
```


- one then clicks on load trace 
- we enter the IP of the server and connect
- we can then fetch all trace (give fake files for the moment)
- we choose a track then we do setTrace
- then getTrace 
- an inspector should open on  the list of steps that we retrieved from the server 

in the inspector -
```st
| selection test |

test := self collect: [ :a | MethodCallAdapteurToPharo createAdapterWithDictionary: a ].

selection := SkSelectionMessagesSentWithSelector new.
selection selector: #bubbleSort.
test select: [ :ps | selection value: ps].
```

## schema

<img width="2511" height="1301" alt="diagrameTTQPharoGemoc drawio (1)" src="https://github.com/user-attachments/assets/990b2304-a086-4d3f-83cd-e423dae4fecf" />


## issues

### Merging GemocProgramState and GemocType in PyBridge-MiniJava-TTQAdapter :

- issue:
	There is currently an issue where we need to merge two class hierarchies. After an analysis of the code, I found that a lot of code between these two classes was duplicated—methods, attributes, and code itself. But there are methods with the same name but different implementations.

- solution:

  	Firstly, I decided to remove all the duplicated code between these two classes by introducing a new common superclass GemocAbstractModelRepresentation, where I pulled up all the duplicated code, attributes, and methods. This solution helped to find the methods with different implementations between these two classes.


  	Next step : find how i will merge the different implementation.

  exemple :

  ```st
  GemocProgramState>>model
	self ensureModel.
	^ model ifNil:[model := programState]
  ```

   ```st
  GemocType>>model
	^ model ifNil: [ model := self ensureModel ]
  ```

Here the code seems to have the same goal. But we need to choose the bottom version, slightly modified, because `self ensureModel` returns nothing and just returns  `self ensureModel` in the block that already affects a value in the model instance variable. By choosing the bottom version, we only reassign model if model is nil, while the top one reassigns model every time the method is called. Plus, the block in the top version is never reached because model always has a value with the call to  `self ensureModel`.
___
```st
GemocType>>build
	GemocProgramStateGenerator new visit: self
```

```st
GemocProgramState>>build
	"self subclassResponsibility "
```

here we must choose the GemocType implementation to be pulled up in the super class, because the subclass of GemocProgramState are define the same way as build in GemocType only one subclass of GemocProgramState keep overriding build
