assert = chai.assert

describe 'appView', ->
  it 'should append two hands to DOM', ->
    assert.strictEqual $('body').find('div').children.length, 2

  it 'should add HTML elements on hit', ->
    window.app.get('playerHand').hit()
    assert.strictEqual $('.player-hand-container').children.length, 2