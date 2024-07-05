var assert = require('chai').assert;

describe('Basic Tests', function() {
  describe('Addition', function() {
    it('should return 2 when 1 and 1 are added', function() {
      assert.equal(1 + 1, 2);
    });
  });

  describe('Subtraction', function() {
    it('should return 0 when 1 is subtracted from 1', function() {
      assert.equal(1 - 1, 0);
    });
  });
});
