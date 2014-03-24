{basename} = require 'path'

module.exports =
  activate: (state) ->
    atom.workspaceView.eachEditorView (editorView) =>
      editor = editorView.getEditor()
      return unless @_isRspecFile(editor.getPath())
      rspecGrammar = atom.syntax.grammarForScopeName 'source.ruby.rspec'
      return unless rspecGrammar?
      editor.setGrammar rspecGrammar

  deactivate: ->

  serialize: ->

  _isRspecFile: (filename) ->
    rspec_filetype = 'spec.rb'
    basename(filename).slice(-rspec_filetype.length) == rspec_filetype
