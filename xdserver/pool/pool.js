const mysql=require('mysql');
//创建数据库连接池
var pool=mysql.createPool({
    host:"127.0.0.1",
    user:"root",
    password:"",
    port:3306,
    connectionLimit:20,
    database:"xindan"
})
 //冻结连接池 不能修改
 Object.freeze(pool);
 //导出连接池对象
  //  module.exports=pool;