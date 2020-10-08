Class {
	#name : #BaselineOfCasinoRestAPI,
	#superclass : #BaselineOf,
	#category : #BaselineOfCasinoRestAPI
}

{ #category : #baselines }
BaselineOfCasinoRestAPI >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfCasinoRestAPI >> defineDependencies: spec [
	spec baseline: 'MooseRestAPI' with: [ spec repository: 'github://badetitou/Moose-REST-API:/src' ]
]

{ #category : #baselines }
BaselineOfCasinoRestAPI >> defineGroups: spec [
	
]

{ #category : #baselines }
BaselineOfCasinoRestAPI >> definePackages: spec [
	spec
		package: 'Casino-REST-API'
		with: [ spec requires: #('MooseRestAPI') ]
]
