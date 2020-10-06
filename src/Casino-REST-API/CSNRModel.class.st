Class {
	#name : #CSNRModel,
	#superclass : #MRAPI,
	#category : #'Casino-REST-API'
}

{ #category : #accessing }
CSNRModel class >> attributes: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'csn-model/<modelID>/entity/<entityID>/attributes'>
	| entity attributes |
	entity := self retrieveEntity: aRequest.
	attributes := entity attributes collect: [ :att | {(#key -> att name) . (#value -> att attributeValue)} asDictionary ].

	^ MROutput json value: (TeaResponse ok body: attributes)
]

{ #category : #accessing }
CSNRModel class >> retrieveEntity: aRequest [
	"I need a model and the entity id"

	| model entityID |
	model := MooseModel root at: (aRequest at: #modelID) asInteger.
	entityID := (aRequest at: #entityID) asInteger.
	^ model detect: [ :el | el mooseID = entityID ]
]

{ #category : #accessing }
CSNRModel class >> sourceCode: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'csn-model/<modelID>/entity/<entityID>/source'>
	| entity |
	entity := self retrieveEntity: aRequest.
	^ MROutput json value: (TeaResponse ok body: {('body' -> entity source sourceText). (#file -> entity source sourceAnchor fileName)} asDictionary)
]
