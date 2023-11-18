import * as express from 'express';
import {Express} from "express";

const router: Express = new express();

router.get('/start', (req, res) => {
  res.render('start');
});

router.use('*', (req, res) => res.status(400).send());

export default router;