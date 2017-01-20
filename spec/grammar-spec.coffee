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
    expect(tokens[0]).toEqual value: 'describe', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.behaviour.rspec']
    expect(tokens[1]).toEqual value: ' PostController ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[2]).toEqual value: 'do', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']

    {tokens} = grammar.tokenizeLine('describe "some text" do')
    expect(tokens[0]).toEqual value: 'describe', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.behaviour.rspec']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[2]).toEqual value: '"', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string.quoted.double.interpolated.ruby', 'punctuation.definition.string.begin.ruby']
    expect(tokens[3]).toEqual value: 'some text', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string.quoted.double.interpolated.ruby']
    expect(tokens[4]).toEqual value: '"', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string.quoted.double.interpolated.ruby', 'punctuation.definition.string.end.ruby']
    expect(tokens[5]).toEqual value: ' ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[6]).toEqual value: 'do', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']

    {tokens} = grammar.tokenizeLine("describe 'some text' do")
    expect(tokens[0]).toEqual value: 'describe', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.behaviour.rspec']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[2]).toEqual value: "'", scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string.quoted.single.ruby', 'punctuation.definition.string.begin.ruby']
    expect(tokens[3]).toEqual value: 'some text', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string.quoted.single.ruby']
    expect(tokens[4]).toEqual value: "'", scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'string.quoted.single.ruby', 'punctuation.definition.string.end.ruby']
    expect(tokens[5]).toEqual value: ' ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[6]).toEqual value: 'do', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']

    {tokens} = grammar.tokenizeLine("describe :some_text do")
    expect(tokens[0]).toEqual value: 'describe', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.rspec.behaviour']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[2]).toEqual value: ':', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'constant.other.symbol.ruby', 'punctuation.definition.constant.ruby']
    expect(tokens[3]).toEqual value: 'some_text', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'constant.other.symbol.ruby']
    expect(tokens[4]).toEqual value: ' ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[5]).toEqual value: 'do', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']

    {tokens} = grammar.tokenizeLine('RSpec.describe PostController do')
    expect(tokens[0]).toEqual value: 'RSpec', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'support.class.ruby']
    expect(tokens[1]).toEqual value: '.', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[2]).toEqual value: 'describe', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.other.behaviour.rspec']
    expect(tokens[3]).toEqual value: ' PostController ', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour']
    expect(tokens[4]).toEqual value: 'do', scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', 'keyword.control.ruby.start-block']

  it 'tokenizes keywords', ->
    keywordLists =
      'keyword.other.example.rspec': ['example', 'fcontext', 'fdescribe', 'fexample', 'fit', 'focus', 'fspecify', 'Given', 'given!', 'include_context', 'include_examples', 'Invariant', 'it', 'it_behaves_like', 'it_should_behave_like', 'its', 'let', 'let!', 'pending', 'scenario', 'shared_examples', 'shared_examples_for', 'skip', 'specify', 'subject', 'xit', 'Then', 'When']
      'keyword.other.hook.rspec': ['after', 'after_suite_parts', 'append_after', 'append_before', 'around', 'before', 'before_suite_parts', 'prepend_after', 'prepend_before']
      'keyword.other.mock.rspec': ['double', 'instance_double', 'instance_spy', 'mock', 'spy', 'stub', 'stub_chain']
      'keyword.other.mock.rspec': ['and_call_original', 'and_raise', 'and_return', 'and_throw', 'and_yield', 'build_child', 'called_max_times', 'expected_args', 'invoke', 'matches']
      'keyword.other.example.rspec': ['should', 'should_not', 'should_not_receive', 'should_receive']
      'keyword.other.example.rspec': ['all', 'allow', 'allow_any_instance_of', 'assigns', 'be', 'by', 'change', 'described_class', 'eq', 'eql', 'equal', 'errors_on', 'exist', 'expect', 'expect_any_instance_of', 'have', 'have_at_least', 'have_at_most', 'have_exactly', 'include', 'is_expected', 'match', 'match_array', 'matcher', '.not_to', 'raise_error', 'raise_exception', 'receive', 'receive_messages', 'respond_to', 'satisfy', 'throw_symbol', '.to', '.to_not', 'when', 'wrap_expectation']
      'keyword.other.example.rspec': ['accept_nested_attributes_for', 'belong_to', 'custom_validate', 'embed_many', 'embed_one', 'validate_associated', 'validate_exclusion_of', 'validate_format_of', 'validate_inclusion_of', 'validate_length_of']
      'keyword.other.example.rspec': ['allow_mass_assignment_of', 'allow_value', 'ensure_exclusion_of', 'ensure_length_of', 'have_secure_password', 'validate_absence_of', 'validate_acceptance_of', 'validate_confirmation_of', 'validate_numericality_of', 'validate_presence_of', 'validate_uniqueness_of']
      'keyword.other.example.rspec': ['advise', 'any_args', 'any_number_of_times', 'anything', 'at_least', 'at_most', 'exactly', 'expected_messages_received', 'generate_error', 'hash_including', 'hash_not_including', 'ignoring_args', 'instance_of', 'matches_at_least_count', 'matches_at_most_count', 'matches_exact_count', 'matches_name_but_not_args', 'negative_expectation_for', 'never', 'no_args', 'once', 'ordered', 'similar_messages', 'times', 'twice', 'verify_messages_received', 'with']
      'keyword.other.example.rspec': ['be_something', 'have_something']
      'support.class.rspec': ['RSpec']

    for scope, list of keywordLists
      for keyword in list
        {tokens} = grammar.tokenizeLine keyword
        expect(tokens[0]).toEqual value: keyword, scopes: ['source.ruby.rspec', scope]


  it 'tokenizes keywords', ->
    keywordLists =
      'keyword.other.behaviour.rspec': ['context', 'describe', 'feature']

    for scope, list of keywordLists
      for keyword in list
        {tokens} = grammar.tokenizeLine keyword
        expect(tokens[0]).toEqual value: keyword, scopes: ['source.ruby.rspec', 'meta.rspec.behaviour', scope]
