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
    origin: ["http://127.0.0.1:5555", "http://localhost:5555", "http://127.0.0.1:5556", "http://127.0.0.1:5557", "http://127.0.0.1:5558"],
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
    // console.log(e, u);
    //创建sql
    var sql = "SELECT id FROM xd_login WHERE email =? AND upwd =md5(?)";
    //执行sql语句并且获取返回结果
    pool.query(sql, [e, u], (err, result) => {
        //判断登录是否成功
        if (err) throw err;
        //将结果返回网页
        // console.log(result.length)
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
            console.log('00000'+id);
            res.send({ code: 1, msg: "登录成功" })
        }
    })
})
server.get("/log",(req,res)=>{
    // 先判断有没有传来退出登录的参数，没有说明是请求用户名，有就退出登录
    var id=req.session.uid;
    // console.log(out); 
    // var id=req.session.uid;
    console.log('22222222'+id);
    if(!id){
            res.send({code:-1,msg:"请登录"});
            return;
          }

        // 创建sql语句
        var sql=`SELECT uname,imgn from xd_login WHERE id = ${id} `;
        pool.query(sql,[id],(err,result)=>{
            if(err) throw err;
            res.send({code:1,meg:"查询成功",data:result});
        })
    
})

// 退出登录
server.get("/LoginA",(req,res)=>{
    // 先判断有没有传来退出登录的参数，没有说明是请求用户名，有就退出登录
    var out=req.query.out; 
    // console.log(out); 
    // var id=req.session.uid;
    // console.log('22222222'+id);
    if(!out){
        // 获取uid 并且判断如果没有请求登录
        var id=req.session.uid;
        console.log('22222222'+id);
        if(!id){
            res.send({code:-1,msg:"请登录"});
            return;
          }
        // 创建sql语句
        var sql="SELECT uname from xd_login WHERE uid = ? ";
        pool.query(sql,[uid],(err,result)=>{
            if(err) throw err;
            res.send({code:1,meg:"查询成功",data:result});
        })
    }else{
        // 退出登录
        req.session.uid ='';
        res.send({code:-1,meg:"退出成功"});
    }
})
// 注册
// server.get("/regstat",(req,res)=>{
// 	var obj=req.query.obj; 
// 	var sql="INSERT INTO xd_login SET ?";
// 	pool.query(sql,[obj],(err,result)=>{
// 		if(err) throw err;
// 		if(result.affectedRows>0){
// 			res.send({code:1,msg:"注册成功"})  
// 		}else("0");
// 	});
// });
//功能一:获取数据库的数据
server.get("/cao", (req, res) => {
    var pno = req.query.pno;
    var ps = req.query.pageSize;
    // console.log(pno);
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
    // console.log(psa);

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
    // console.log(psx);

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
    // console.log(pnopro);
    // console.log(pspro);
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

 
// 分类后的商品列表 从小到大
server.get("/prolist1", (req, res) => {
    var pnopro = req.query.pno;
    var pspro = req.query.pageSize;
    // console.log(pnopro);
    // console.log(pspro);
    if (!pnopro) {
        pnopro = 1;
    } if (!pspro) {
        pspro = 10;
    }
    //创建sql语句
    var sql = "SELECT id,img_url,title,details,price";
    sql += " FROM shangpin_list";
    sql += " ORDER BY price ASC LIMIT ?,?";
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
 // 分类后的商品列表 从大到大
server.get("/prolist2", (req, res) => {
    var pnopro = req.query.pno;
    var pspro = req.query.pageSize;
    // console.log(pnopro);
    // console.log(pspro);
    if (!pnopro) {
        pnopro = 1;
    } if (!pspro) {
        pspro = 10;
    }
    //创建sql语句
    var sql = "SELECT id,img_url,title,details,price";
    sql += " FROM shangpin_list";
    sql += " ORDER BY price desc LIMIT ?,?";
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





//首页商品
server.get("/detail", (req, res) => {
    var id = req.query.id;
    var sql = "select * from xinpinshashi  where id=?"
    pool.query(sql, [id], (err, result) => {
        if (err) throw err;
        res.send({ code: 1, msg: "查询成功", data: result })
    })
})
// 分类商品
server.get("/detail2", (req, res) => {
    var id = req.query.id;
    var sql = "select * from shangpin_list  where id=?"
    pool.query(sql, [id], (err, result) => {
        if (err) throw err;
        res.send({ code: 1, msg: "查询成功", data: result })
    })
})
// server.get("/deail2", (req, res) => {
//     var sql = "select id,title,price,img_url from xinpinshashi ";
//     pool.query(sql, (err, result) => {
//         if (err) throw err;
//         res.send({ code: 1, msg: "查询成功", data: result })
//     })
// })
// 购物车
server.get("/addcart", (req, res) => {
    var uid = req.session.uid;
    if (!uid) {
        res.send({ code: -1, msg: "请登录" });
        return;
    }
    // 获取客户端数据
    // var id=req.query.id;
    var lid = parseInt(req.query.lid);
    var price = req.query.price;
    var title = req.query.title;
    var count=parseInt(req.query.count);
    var imgurl=req.query.imgurl;
    // console.log(lid, imgurl)
    //    创建查询sql:当前用户是否购买过此商品
    var sql = "select id from xinpin_cart";
    sql += " where uid=? and lid=?";
    pool.query(sql, [uid, lid], (err, result) => {
        if (err) throw err;
        console.log(result.length)
        if (result.length <= 0) {           
            var sql = `INSERT INTO xinpin_cart VALUES(null,${lid},${price},'1','${title}',${uid},'${imgurl}')`;
        } else {
            var sql = `UPDATE xinpin_cart SET count=count+1 WHERE uid=${uid} AND lid=${lid}`;
        }
        //7.执行sql获取返回结果
        pool.query(sql, (err, result) => {
            if (err) throw err;
            //8.
            if (result.affectedRows > 0) {
                res.send({ code: 1, msg: "商品添加成功" });
                console.log(result);
            } else {
                res.send({ code: -2, msg: "添加失败" })
            }
        })

    })

})
// 购物车
server.get("/carts", (req, res) => {
    var uid = req.session.uid;
    // console.log(uid);
    if (!uid) {
        res.send({ code: -1, msg: "请登录" });
        return;
    } else {
        var sql = "SELECT id ,title,price,imgurl,count FROM";
        sql += " xinpin_cart WHERE uid=?";
        pool.query(sql, [uid], (err, result) => {
            if (err) throw err;
            res.send({ code: 1, msg: "查询成功", data: result })
            // console.log(res.send);
        })
    }
})

// server.get("/count",(req,res)=>{
//     var count=req.body.count;
//     var sql="update xinpin_cart set count where id=?";
//     pool.query(sql,[count],(err,result)=>{
//         if(err) throw err;
//         console.log(result);
//     })
// })


server.get("/delItem",(req,res)=>{
    //0:判断是否登录
    var uid = req.session.uid;
    if(!uid){
       res.send({code:-2,msg:"请登录"});
       return;
    } 
    //1：获取客户端发送数据id
    var id = req.query.id;
    console.log(id);
    //2: 创建sql语句
    var sql = "DELETE FROM xinpin_cart WHERE id=?";
    //3: 执行sql语句
    pool.query(sql,[id],(err,result)=>{
       if(err)throw err;
       //4: 获取服务器获取结果判断删除是否成功
       console.log(result);
       if(result.affectedRows>0){
   
         res.send({code:1,msg:"删除成功"});
       }else{
         res.send({code:-1,msg:"删除失败"});
       }
    })
   })
   //功能六:删除购物车中多个 商品
   server.get("/delItems",(req,res)=>{
       //0.判断用户是否登录
       var uid=req.session.uid;
       if(!uid){
           res.send({code:-2,msg:"请登录"});
           return;
       }
       //1.获取参数id=1,2,3
       var id=req.query.id;
       //2.创建sql语句
       var sql=`DELETE FROM xinpin_cart WHERE id IN (${id})`;
       //3.执行sql语句
       pool.query(sql,(err,result)=>{
           if(err) throw err;
           if(result.affectedRows>0){
               res.send({code:1,msg:"删除成功"})
           }else{
               res.send({code:0,msg:"删除失败"})
           }
       })
   })
   //4.获取服务器返回结果
   //5将结果返回客户端


