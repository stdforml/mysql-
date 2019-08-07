#mysql复习
#一、复习前的准备

#二、基础知识
#1.数据库的连接

#2.库级知识
#2.1 显示数据库：
show databases;
#2.2 选择数据库
use test;
#2.3 创建数据库
create database test charset utf8;
#2.4 删除数据库
drop database test;

#3.表级操作
#3.1 显示库下面的表
show tables;
#3.2 查看表的结构
desc courses;
#3.3 查看表的创建过程
show create table courses;
#3.4 创建表
# create table tbName (
# 列名称1 列类型 [列参数] [not null default],
# ……列2……
# ……
# 列名称N 列类型 [列参数] [not null default]
#）engine myisam/innodb charset utf8/gbk
#3.4的例子 
create table user (
id int auto_increment,
name varchar(20) not null default '',
age tinyint unsigned not null default 0,
index id (id)   #索引名为id的索引为id所在的这一列 
)engine=innodb charset=utf8;
#3.5修改表
#3.5.1修改表之增加列 
#alter table tbName add 列名称1 列类型 [列参数] [not null default ]
#3.5.2修改表之修改列 
#alter table tbName change 旧列名 新列名 列类型 [列参数] [not null default ]
#3.5.3修改表之减少列 
#alter table tbName drop 列名称；
#3.5.4修改表之增加主键 
#alter table tbName add primary key(主键所在列名);
#3.5.5修改表之删除主键 
#alter table tbName drop primary key;
#3.5.6修改表之增加索引 
#alter table tbName add [unique|fulltext] index 索引名(列名)；
#3.5.7修改表之删除索引 
#alter table tbName drop index 索引名;
#3.5.8清空表的数据 
#truncate tableName;

#4.列类型讲解 
#列类型： 
#数值型：整型(tinyint, smallint, mediumint, int, bigint)、小数型(浮点型/定点型) float(D,M), decimal(D,M)  
#字符型：char, varchar, text, blob 
#日期时间类型：year, date, time, datetime, timestamp

#5.增删改查基本操作 
#5.1插入数据 
#insert into 表名(col1,col2,……) values(val1,val2,……); 插入指定列
#insert into 表名 values (,,,,); 插入所有列 
#insert into 表名 values 
#(val1,val2,……),
#(val1,val2,……),
#(val1,val2,……); 一次插入多行 
#5.2修改数据 
#update tbName
#set
#col1=newval1,
#col2=newval2,
#……
#colN=newvalN
#where 条件;
#5.3删除数据 
#delete from tbName where 条件;
#5.4查询数据  
#(1)条件查询 where
#(2)分组 group by 一般要配合5个聚合函数使用：max, min, sum, avg, count
#(3)筛选 having
#(4)排序 order by
#(5)限制 limit

#6.连接查询 

#7.子查询 

#8.字符集 


#三、查询知识 
#1.基础查询where的练习： 
#查询出满足以下条件的商品 
#1.1 主键为32的商品 
select goods_id, goods_name, shop_price
from goods
where goods_id=32;
#1.2不属于第3栏目的所有商品 
select goods_id, goods_name, cat_id, shop_price
from goods
where cat_id!=3;
#1.3本店价格高于3000元的商品 
select goods_id, goods_name, cat_id, shop_price
from goods
where shop_price>3000;
#1.4本店价格低于或等于100元的商品 
select goods_id, goods_name, shop_price
from goods
where shop_price<=100;
#1.5取出第4栏目或第11栏目的商品（不许用or）
select goods_id, cat_id, goods_name, shop_price
from goods
where cat_id in (4,11);
#1.6取出100<=价格<=500的商品（不许用and）
select goods_id, cat_id, goods_name, shop_price
from goods
where shop_price between 100 and 500;
#1.7取出不属于第3栏目且不属于第11栏目的商品（and,或not in 分别实现）
select goods_id, cat_id, goods_name, shop_price
from goods
where cat_id!=3 and cat_id!=11;
select goods_id, cat_id, goods_name, shop_price
from goods
where cat_id not in (3, 11);
#1.8取出价格大于100且小于300,或者大于4000且小于5000的商品
select goods_id, cat_id, goods_name, shop_price
from goods
where (shop_price between 100 and 300) or (shop_price between 4000 and 5000);
#1.9取出第3个栏目下面价格<1000或>3000,并且点击量>5的系列商品
select goods_id, cat_id, goods_name, shop_price, click_count
from goods
where cat_id=3 and (shop_price<1000 or shop_price>3000) and click_count>5;
#1.10取出第1个栏目下面的商品(注意:1栏目下面没商品,但其子栏目下有)
select goods_id, cat_id, goods_name, shop_price
from goods
where cat_id in (2,3,4,5);
#1.11取出名字以"诺基亚"开头的商品
select goods_id, cat_id, goods_name, shop_price
from goods
where goods_name like '诺基亚%';
#1.12取出名字为"诺基亚Nxx"的手机
select goods_id, cat_id, goods_name, shop_price
from goods
where goods_name like '诺基亚N__';
#1.13取出名字不以"诺基亚"开头的商品
select goods_id, cat_id, goods_name, shop_price
from goods
where goods_name not like '诺基亚%';
#1.14取出第3个栏目下面价格在1000到3000之间,并且点击量>5 "诺基亚"开头的系列商品
select goods_id, cat_id, goods_name, click_count, shop_price
from goods
where cat_id=3 and (shop_price between 1000 and 3000) and click_count>5 and goods_name like '诺基亚%';

#一道面试题
#有如下表和数组
#把num值处于[20,29]之间,改为20
#num值处于[30,39]之间的,改为30
create table main (
num tinyint not null default 0)engine MyISAM charset utf8;
#drop table main;
show tables;
desc main;
insert into main values (3),(12),(15),(25),(23),(29),(34),(37),(32),(45),(48),(52);
select * from main; 
update main set num=20 where num between 20 and 29;
update main set num=30 where num between 30 and 39;

update mian set num=floor(num/10)*10
where (num between 20 and 29) or (num between 30 and 39);

select num,
case when num between 20 and 29 then 20
when num between 30 and 39 then 30
else num end as newnum
from main;
select * from main;

#练习题:
#把good表中商品名为'诺基亚xxxx'的商品,改为'HTCxxxx',
#提示:大胆的把列看成变量,参与运算,甚至调用函数来处理 .
#substring(),concat()
select goods_id, goods_name, 
concat('HTC', substring(goods_name,4)), shop_price
from goods
where goods_name like '诺基亚%';

#2.分组查询group
#2.1查出最贵的商品的价格
select max(shop_price)
from goods;
#2.2查出最大(最新)的商品编号
select max(goods_id) from goods;
#2.3查出最便宜的商品的价格
select min(shop_price) from goods;
#2.4查出最旧(最小)的商品编号
select min(goods_id) from goods;
#2.5查询该店所有商品的库存总量
select sum(goods_number) from goods;
#2.6查询所有商品的平均价
select avg(shop_price) from goods;
#2.7查询该店一共有多少种商品
select count(*) from goods;
#2.8查询每个栏目下面
#最贵商品价格
#最低商品价格
#商品平均价格
#商品库存量
#商品种类
#提示:(5个聚合函数,sum,avg,max,min,count与group综合运用)
 select cat_id, max(shop_price), min(shop_price), avg(shop_price), sum(goods_number), count(*)
 from goods
 group by cat_id;
 
 #3.having与group综合运用查询 
 #3.1查询该店的商品比市场价所节省的价格
 select goods_id, goods_name, cat_id, (market_price-shop_price) as discount
 from goods
 where market_price>shop_price;
 #3.2查询每个商品所积压的货款(提示:库存*单价)
 select goods_id, goods_name, cat_id, goods_number*shop_price
 from goods;
 #3.3查询该店积压的总货款
 select sum(goods_number*shop_price) from goods;
 #3.4查询该店每个栏目下面积压的货款
 select cat_id, sum(goods_number*shop_price)
 from goods
 group by cat_id;
 #3.5查询比市场价省钱200元以上的商品及该商品所省的钱(where和having分别实现)
 select goods_id, goods_name, (market_price-shop_price) as discount
 from goods
 where market_price>shop_price and market_price-shop_price>=200;
 
 select goods_id, goods_name, (market_price-shop_price) as discount 
 from goods
 where market_price>shop_price
 having discount>=200;
 #3.6查询积压货款超过2W元的栏目,以及该栏目积压的货款
 select cat_id, sum(shop_price*goods_number) as zhk
 from goods
 group by cat_id
 having zhk>20000;
 #3.7where-having-group综合练习题
 #有如下表及数据
 #要求:查询出2门及2门以上不及格者的平均成绩
 insert into result
 values
 ('张三','数学',90),
 ('张三','语文',50),
 ('张三','地理',40),
 ('李四','语文',55),
 ('李四','政治',45),
 ('王五','政治',30);
 select * from result;
 select name, avg(score), sum(score<60) as t
 from result 
 group by name
 having t>=2;
 
 #将上面的问题分解为以下几个问题 
select name, avg(score) from result group by name;
select name, score<60 from result;
select name, sum(score<60) from result group by name;
select name, avg(score), sum(score<60) from result group by name;
select name, avg(score), sum(score<60) as gk from result group by name having gk>=2;




