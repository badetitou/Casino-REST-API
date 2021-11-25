Extension { #name : #CSNUICWModel }

{ #category : #'*Casino-REST-API' }
CSNUICWModel >> webRootEntities [
	^ (self allWithSubTypesOf: CSNPage) asOrderedCollection 
]

{ #category : #'*Casino-REST-API' }
CSNUICWModel >> webSummary [

	^ { 
		  { 
			  (#name -> #Widget).
			  (#value -> (self allWithSubTypesOf: CSNWidget) size) }
			  asDictionary.
		  { 
			  (#name -> #DTO).
			  (#value -> (self allWithSubTypesOf: CSNBuEntity) size) }
			  asDictionary.
		  { 
			  (#name -> #Services).
			  (#value -> (self allWithSubTypesOfAny: { 
					    CSNService.
					    CSNServiceAPI.
					    CSNServiceAPIParameter }) size) } asDictionary.
		  { 
			  (#name -> #Actions).
			  (#value -> (self allWithSubTypesOf: CSNAction) size) }
			  asDictionary.
		  { 
			  (#name -> #Attributes).
			  (#value -> (self allWithSubTypesOf: CSNAttribute) size) }
			  asDictionary.
		  { 
			  (#name -> #Layouts).
			  (#value -> (self allWithSubTypesOf: CSNLLayout) size) }
			  asDictionary }
]
