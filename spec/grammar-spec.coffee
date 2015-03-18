describe 'rspec grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-rspec')

    runs ->
      grammar = atom.grammars.grammarForScopeName('source.ruby.rspec')

  it 'parses the grammar', ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe 'source.ruby.rspec'

  it 'tokenizes describe', ->
    {tokens} = grammar.tokenizeLine('describe PostController do')
    expect(tokens[0].value).toEqual 'describe'
    expect(tokens[0].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.rspec.behaviour']
    expect(tokens[1].value).toEqual ' PostController '
    expect(tokens[1].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[2].value).toEqual 'do'
    expect(tokens[2].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']

    {tokens} = grammar.tokenizeLine('describe "some text" do')
    expect(tokens[0].value).toEqual 'describe'
    expect(tokens[0].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.rspec.behaviour']
    expect(tokens[1].value).toEqual ' "'
    expect(tokens[1].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour', 'string']
    expect(tokens[2].value).toEqual 'some text'
    expect(tokens[2].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour', 'string']
    expect(tokens[3].value).toEqual '"'
    expect(tokens[3].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour', 'string']
    expect(tokens[4].value).toEqual ' '
    expect(tokens[4].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[5].value).toEqual 'do'
    expect(tokens[5].scopes).toEqual ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']
