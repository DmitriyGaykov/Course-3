import {parseString} from "xml2js";

export const xmlMiddleware = (req, res, next) => {
  if (req.is('text/xml')) {
    parseString(req.body, (err, result) => {
      if (err) {
        return next(err);
      }
      // Разобранный XML будет доступен в req.body
      req.body = result;
      next();
    });
  } else {
    next();
  }
}