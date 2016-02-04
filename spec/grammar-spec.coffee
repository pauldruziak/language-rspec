describe 'rspec grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-rspec')

    runs ->
      grammar = atom.grammars.grammarForScopeName('source.ruby.rspec')

  it 'parses the grammar', ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'source.ruby.rspec'

  it 'tokenizes describe', ->
    {tokens} = grammar.tokenizeLine('describe PostController do')
    expect(tokens[0]).toEqual value: 'describe', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.rspec.behaviour']
    expect(tokens[1]).toEqual value: ' PostController ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[2]).toEqual value: 'do', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']

    {tokens} = grammar.tokenizeLine('describe "some text" do')
    expect(tokens[0]).toEqual value: 'describe', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.rspec.behaviour']
    expect(tokens[1]).toEqual value: ' "', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string']
    expect(tokens[2]).toEqual value: 'some text', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string']
    expect(tokens[3]).toEqual value: '"', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string']
    expect(tokens[4]).toEqual value: ' ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[5]).toEqual value: 'do', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']

    {tokens} = grammar.tokenizeLine('RSpec.describe PostController do')
    expect(tokens[0]).toEqual value: 'RSpec', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'support.class.ruby']
    expect(tokens[1]).toEqual value: '.', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[2]).toEqual value: 'describe', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.rspec.behaviour']
    expect(tokens[3]).toEqual value: ' PostController ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[4]).toEqual value: 'do', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']
