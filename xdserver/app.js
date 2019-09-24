//1.下载第三方模块 
//express/express-session/cors/mysql
//2.将第三方模块引入到当前程序中
const express = require("express");
const session = require("express-session");
const cors = require("cors");
const mysql = require("mysql");
//3.创建数据库连接池
var pool = mysql.createPool({
    host: "127.0.0.1",
    user: "root",
    password: "",
    port: 3306,
    connectionLimit: 20,
    database: "xindan"
})
//4.创建 web服务器监听8080端口
var server = express();
server.listen(8081);
//5.处理跨域cors
//5.1配置允许访问程序地址(脚手架)
//http://127.0.0.1:5050  

//5.2每请求是否验证true
server.use(cors({
    origin: ["http://127.0.0.1:5555", "http://localhost:5555", "http://127.0.0.1:5557", "http://127.0.0.1:5558"],
    credentials: true
}))

//6.配置session
//#session 配置一定要在所有请求之前
server.use(session({
    secret: "128位字符串",  //安全字符串
    resave: true,    //#每次请求保存数据 
    saveUninitialized: true  //#保存初始化数据
}));
//7.配置静态目录
//http://127.0.0.1:8080/01.jpg
server.use(express.static("public"));
//邮箱登录 
//http://127.0.0.1:8080/email?email=123456@qq.com&upwd=123
server.get("/Email", (req, res) => {
    //接收页面传递数据,用户名和密码
    var e = req.query.email;
    var u = req.query.upwd;
    console.log(e, u);
    //创建sql
    var sql = "SELECT id FROM xd_login WHERE email =? AND upwd =md5(?)";
    //执行sql语句并且获取返回结果
    pool.query(sql, [e, u], (err, result) => {
        //判断登录是否成功
        if (err) throw err;
        //将结果返回网页
        console.log(result.length)
        if (result.length == 0) {
            res.send({ code: -1, msg: "用户名或密码有误" })
        } else {
            //获取当前登录用户id
            var id = result[0].id;
            req.session.uid = id;
            res.send({ code: 1, msg: "登录成功" })
        }
    })
})
//手机登录
server.get("/Login", (req, res) => {
    //接收页面传递数据 ,用户名和验证码
    var p = req.query.phone;

    //创建sql
    var sql = "SELECT id FROM xd_login WHERE phone=?";
    //执行sql语句并且获取返回结果
    pool.query(sql, p, (err, result) => {
        //判断登录是否成功
        //如果有错抛出
        if (err) throw err;

        if (result.length == 0) {
            res.send({ code: -1, msg: "手机号错了" })
        } else {
            //获取当前登录用户id
            var id = result[0].id;
            req.session.uid = id;
            res.send({ code: 1, msg: "登录成功" })
        }
    })
})

//功能一:获取数据库的数据
server.get("/cao", (req, res) => {
    var pno = req.query.pno;
    var ps = req.query.pageSize;
    console.log(pno);
    if (!pno) {
        pno = 1;
    } if (!ps) {
        ps = 4;
    }
    //创建sql语句
    var sql = "SELECT id,img_url,title,price";
    sql += " FROM new_list";
    sql += " LIMIT ?,?";
    var offset = (pno - 1) * ps;
    ps = parseInt(ps);
    //发送sql语句
    pool.query(sql, [offset, ps], (err, result) => {
        if (err) throw err;
        res.send({
            code: 1, msg: "查询成功",
            data: result
        })
    })
})

// 人气推荐
//功能一:获取数据库的数据
server.get("/md", (req, res) => {
    var pnoa = req.query.pno;
    var psa = req.query.pageSize;
    console.log(psa);

    if (!pnoa) {
        pnoa = 1;
    } if (!psa) {
        psa = 4;
    }
    //创建sql语句
    var sql = "SELECT id,img_url,title,price";
    sql += " FROM ren_qi";
    sql += " LIMIT ?,?";
    var offset = (pnoa - 1) * psa;
    psa = parseInt(psa);
    //发送sql语句
    pool.query(sql, [offset, psa], (err, result) => {
        if (err) throw err;
        res.send({
            code: 1, msg: "查询成功",
            data: result
        })
    })
})

server.get("/xinpin", (req, res) => {
    var pnox = req.query.pno;
    var psx = req.query.pageSize;
    console.log(psx);

    if (!pnox) {
        pnox = 1;
    } if (!psx) {
        psx = 4;
    }
    //创建sql语句
    var sql = "SELECT id,img_url,title,price";
    sql += " FROM xinpinshashi";
    sql += " LIMIT ?,?";
    var offset = (pnox - 1) * psx;
    psx = parseInt(psx);
    //发送sql语句
    pool.query(sql, [offset, psx], (err, result) => {
        if (err) throw err;
        res.send({
            code: 1, msg: "查询成功",
            data: result
        })
    })
})










// 分类后的商品列表
server.get("/prolist", (req, res) => {
    var pnopro = req.query.pno;
    var pspro = req.query.pageSize;
    console.log(pnopro);
    console.log(pspro);
    if (!pnopro) {
        pnopro = 1;
    } if (!pspro) {
        pspro = 10;
    }
    //创建sql语句
    var sql = "SELECT id,img_url,title,details,price";
    sql += " FROM shangpin_list";
    sql += " LIMIT ?,?";
    var offset = (pnopro - 1) * pspro;
    pspro = parseInt(pspro);
    //发送sql语句
    pool.query(sql, [offset, pspro], (err, result) => {
        if (err) throw err;
        res.send({
            code: 1, msg: "查询成功",
            data: result
        })
    })
})

server.get("/detail",(req,res)=>{
    var id=req.query.id;
    var sql="select * from xinpinshashi  where id=?"
    pool.query(sql,[id],(err,result)=>{
        if(err) throw err;
        res.send({code:1,msg:"查询成功",data:result})
    })
})





