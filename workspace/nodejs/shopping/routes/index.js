
var express = require('express');
var router = express.Router();
const ProductController = require('../controllers/shop')
const upload = require('../config/upload')
const passport = require('../config/passport')
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/shopping', ProductController.getAll);
router.get('/shopping/delete', ProductController.removeProduct);
router.get('/detail', ProductController.get);

router.get('/new-product',  passport.auth(), (_, res) => res.render('new-product'));
router.post('/new-product', passport.auth(), upload.single('image'), ProductController.addNewProduct);

module.exports = router;
