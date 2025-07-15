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

<img width="901" height="741" alt="routesServer drawio (1)" src="https://github.com/user-attachments/assets/26737bdb-1457-4652-912d-9fb5a372cf17" />

## Current state of progress

For the creators of dsl: 

the MMEWC interface only allows to create wrappers for minijava DSL of which a representation exists in hard in pharo.

For users:

A user can only retrieve an already existing minijava trace. 
In this trace only the case of method calls for minijava are present, and in Pharo there is only one adapter for methodCall in order to be able to perform selection functions.

<img width="753" height="872" alt="image" src="https://github.com/user-attachments/assets/ddab8b12-f571-4662-8ed8-2b27c468ae6a" />

this sceenshot shows the creation of a TTQ on method calls whose method is called bubblesort, which uses the dictionary received from the server and the adapter.

## prochine réalisation 

For the creators of dsl: 

- be able to retrieve the AST of any DSL and fill the list of choices with each of its elements and be able to create wrappers based on the element of this AST

For users:

- reutiliser le TraceLoader afin de l'adapter au server Gemoc, avec les routes `setTrace` et `getTrace`
- adapt the DynamicTTQCreatorPresenter so that after loading the trace, we can create selection functions only on elements of the trace that have been retrieved, and that after creating the selection functions, we can apply them to the trace 

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
