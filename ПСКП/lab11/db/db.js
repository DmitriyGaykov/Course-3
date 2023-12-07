import {Faculty, Pulpits, AuditoriumTypes, Subjects, Auditoriums} from "./repositories/index.js";
import Sql from 'mssql';

export class DB {
  static db = new DB();
  
  static getConnection() {
    return DB.db;
  }
  
  sql = null;
  
  constructor() {
    const config = {
      user: 'sa',
      password: '1111',
      server: 'localhost',
      database: 'UNIVER',
      options: {
        encrypt: false
      },
      pool: {
        min: 4,
        max: 10,
        idleTimeoutMillis: 30000
      }
    };
    
    this.connect(config);
  }
  
  async connect(config) {
    await Sql.connect(config);
    this.sql = Sql;
    this.faculties = new Faculty(Sql);
    this.pulpits = new Pulpits(Sql);
    this.subjects = new Subjects(Sql);
    this.auditoriumTypes = new AuditoriumTypes(Sql);
    this.auditoriums = new Auditoriums(Sql);
  }
}