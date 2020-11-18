var expect = require('chai').expect;
const request = require('supertest');

describe('All Test', function () {

  let cookie = ''
  it('Login Test', function (done) {
    request("http://localhost:3000/")
      .post('auth/login')
      .send({
        username: 'ami',
        password: 'ami'
      })
      .end(function (err, res) {
        if (!err) {
          cookie = res.header['set-cookie']
          done()
        }
      })
  });

  it('Add Product To Cart', function (done) {
    request("http://localhost:3000/")
      .post('cart/add')
      .set('Cookie', cookie)
      .set('Content-Type','application/json')
      .send({
        product_id: '5e12b0e461a6bc98a014d764',
      })
      .expect(200, done)
  });

  it('Remove Product To Cart', function (done) {
    request("http://localhost:3000/")
      .post('cart/add')
      .set('Cookie', cookie)
      .set('Content-Type','application/json')
      .send({
        product_id: '5e12b0e461a6bc98a014d764',
      })
      .expect(200, done)
  });

});