create table dataloadtb(
id int , entry_date date , c1 varchar(20),c2 varchar(20),c3 varchar(20),c4 varchar(20)
,c5 varchar(20),c6 varchar(20),c7 varchar(20),c8 varchar(20),c9 varchar(20),c10 varchar(20),c11 varchar(20),c12 varchar(20)
,c13 varchar(20),c14 varchar(20),c15 varchar(20),c16 varchar(20),c17 varchar(20),c18 varchar(20),c19 varchar(20)
,c20 varchar(20),c21 varchar(20),c22 varchar(20),c23 varchar(20),c24 varchar(20),c25 varchar(20),c26 varchar(20)
,c27 varchar(20),c28 varchar(20),c29 varchar(20),c30 varchar(20),c31 varchar(20),c32 varchar(20),c33 varchar(20)
,c34 varchar(20),c35 varchar(20),c36 varchar(20),c37 varchar(20),c38 varchar(20),c39 varchar(20),c40 varchar(20)
,c41 varchar(20),c42 varchar(20),c43 varchar(20),c44 varchar(20),c45 varchar(20),c46 varchar(20),c47 varchar(20),c48 varchar(20)
);
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
set nocount on
declare @x int 
declare @FromDate date = '2011-01-01'
declare @ToDate date = '2014-12-31'
select @x=1
begin tran
while @x<5000000
begin 
 insert into dataloadtb (id,entry_date , c1 ,c2 ,c3 ,c4 
,c5 ,c6 ,c7 ,c8 ,c9 ,c10 ,c11 ,c12 
,c13 ,c14 ,c15 ,c16 ,c17 ,c18 ,c19 
,c20 ,c21 ,c22 ,c23 ,c24 ,c25 ,c26 
,c27 ,c28 ,c29 ,c30 ,c31 ,c32 ,c33 
,c34 ,c35 ,c36 ,c37 ,c38 ,c39 ,c40 
,c41 ,c42 ,c43 ,c44 ,c45 ,c46 ,c47 ,c48 )
 values((@x),
 ( dateadd(day, rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), @FromDate))
 ,('rqqqqqa'+convert(varchar(5),@x)),('adfghjr'+convert(varchar(5),@x)),('txczcza'+convert(varchar(5),@x)),
 ('asdadat'+convert(varchar(5),@x)),('iffsdfda'+convert(varchar(5),@x)),('afsffdfi'+convert(varchar(5),@x)),
 ('dfdfsda'+convert(varchar(5),@x)),('fsdfsdpa'+convert(varchar(5),@x)),('adfsfsp'+convert(varchar(5),@x)),
 ('sazvcv'+convert(varchar(5),@x)),('askjkjk'+convert(varchar(5),@x)),('dhjghna'+convert(varchar(5),@x)),
 ('asdwqcvvd'+convert(varchar(5),@x)),('fdfdfdvdvda'+convert(varchar(5),@x)),('advdvdfdff'+convert(varchar(5),@x)),
 ('gfgfgfvfva'+convert(varchar(5),@x)),('vnjyjhag'+convert(varchar(5),@x)),('ukujmha'+convert(varchar(5),@x)),
 ('ajhhnfrth'+convert(varchar(5),@x)),('jbrrvdva'+convert(varchar(5),@x)),('kwdwd3wda'+convert(varchar(5),@x)),
 ('aewddwdwk'+convert(varchar(5),@x)),('lefe3dsdwa'+convert(varchar(5),@x)),('fedredcal'+convert(varchar(5),@x)),
 ('acedf3en'+convert(varchar(5),@x)),('nasdfga'+convert(varchar(5),@x)),('voiuytrewa'+convert(varchar(5),@x)),
 ('x3tyuiojhgfa'+convert(varchar(5),@x)),('ertyuiuma'+convert(varchar(5),@x)),('fddfddcba'+convert(varchar(5),@x)),
 ('afdcerem'+convert(varchar(5),@x)),('bdfewertyua'+convert(varchar(5),@x)),('ksdfga'+convert(varchar(5),@x)),
 ('fjhgfdsa'+convert(varchar(5),@x)),('azxcvbo'+convert(varchar(5),@x)),('uytreaj'+convert(varchar(5),@x)),
 ('asdfghe'+convert(varchar(5),@x)),('rsdfgha'+convert(varchar(5),@x)),('3456gtfrewat'+convert(varchar(5),@x)),
 ('auhjhwerty'+convert(varchar(5),@x)),('xcvbaq'+convert(varchar(5),@x)),('alkjhgfde'+convert(varchar(5),@x)),
 ('sauytre'+convert(varchar(5),@x)),('aatrewq'+convert(varchar(5),@x)),('azsdfghjk'+convert(varchar(5),@x)),
 ('axwertyuio'+convert(varchar(5),@x)),('achgfds'+convert(varchar(5),@x)),('hgrewab'+convert(varchar(5),@x))

  )
 select @x=@x+1
 END
 commit tran

 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
select count(*) from dataloadtb
 with (nolock)
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
create table latestdata(
id int , entry_date date , c1 varchar(20),c2 varchar(20),c3 varchar(20),c4 varchar(20)
,c5 varchar(20),c6 varchar(20),c7 varchar(20),c8 varchar(20),c9 varchar(20),c10 varchar(20),c11 varchar(20),c12 varchar(20)
,c13 varchar(20),c14 varchar(20),c15 varchar(20),c16 varchar(20),c17 varchar(20),c18 varchar(20),c19 varchar(20)
,c20 varchar(20),c21 varchar(20),c22 varchar(20),c23 varchar(20),c24 varchar(20),c25 varchar(20),c26 varchar(20)
,c27 varchar(20),c28 varchar(20),c29 varchar(20),c30 varchar(20),c31 varchar(20),c32 varchar(20),c33 varchar(20)
,c34 varchar(20),c35 varchar(20),c36 varchar(20),c37 varchar(20),c38 varchar(20),c39 varchar(20),c40 varchar(20)
,c41 varchar(20),c42 varchar(20),c43 varchar(20),c44 varchar(20),c45 varchar(20),c46 varchar(20),c47 varchar(20),c48 varchar(20)
);
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
set nocount on
declare @x int 
declare @FromDate date = '2020-01-01'
declare @ToDate date = '2021-05-24'
select @x=1
begin tran
while @x<=250000
begin 
 insert into latestdata (id,entry_date , c1 ,c2 ,c3 ,c4 
,c5 ,c6 ,c7 ,c8 ,c9 ,c10 ,c11 ,c12 
,c13 ,c14 ,c15 ,c16 ,c17 ,c18 ,c19 
,c20 ,c21 ,c22 ,c23 ,c24 ,c25 ,c26 
,c27 ,c28 ,c29 ,c30 ,c31 ,c32 ,c33 
,c34 ,c35 ,c36 ,c37 ,c38 ,c39 ,c40 
,c41 ,c42 ,c43 ,c44 ,c45 ,c46 ,c47 ,c48 )
 values((@x),
 ( dateadd(day, rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), @FromDate))
 ,('rqqqqqa'+convert(varchar(5),@x)),('adfghjr'+convert(varchar(5),@x)),('txczcza'+convert(varchar(5),@x)),
 ('asdadat'+convert(varchar(5),@x)),('iffsdfda'+convert(varchar(5),@x)),('afsffdfi'+convert(varchar(5),@x)),
 ('dfdfsda'+convert(varchar(5),@x)),('fsdfsdpa'+convert(varchar(5),@x)),('adfsfsp'+convert(varchar(5),@x)),
 ('sazvcv'+convert(varchar(5),@x)),('askjkjk'+convert(varchar(5),@x)),('dhjghna'+convert(varchar(5),@x)),
 ('asdwqcvvd'+convert(varchar(5),@x)),('fdfdfdvdvda'+convert(varchar(5),@x)),('advdvdfdff'+convert(varchar(5),@x)),
 ('gfgfgfvfva'+convert(varchar(5),@x)),('vnjyjhag'+convert(varchar(5),@x)),('ukujmha'+convert(varchar(5),@x)),
 ('ajhhnfrth'+convert(varchar(5),@x)),('jbrrvdva'+convert(varchar(5),@x)),('kwdwd3wda'+convert(varchar(5),@x)),
 ('aewddwdwk'+convert(varchar(5),@x)),('lefe3dsdwa'+convert(varchar(5),@x)),('fedredcal'+convert(varchar(5),@x)),
 ('acedf3en'+convert(varchar(5),@x)),('nasdfga'+convert(varchar(5),@x)),('voiuytrewa'+convert(varchar(5),@x)),
 ('x3tyuiojhgfa'+convert(varchar(5),@x)),('ertyuiuma'+convert(varchar(5),@x)),('fddfddcba'+convert(varchar(5),@x)),
 ('afdcerem'+convert(varchar(5),@x)),('bdfewertyua'+convert(varchar(5),@x)),('ksdfga'+convert(varchar(5),@x)),
 ('fjhgfdsa'+convert(varchar(5),@x)),('azxcvbo'+convert(varchar(5),@x)),('uytreaj'+convert(varchar(5),@x)),
 ('asdfghe'+convert(varchar(5),@x)),('rsdfgha'+convert(varchar(5),@x)),('3456gtfrewat'+convert(varchar(5),@x)),
 ('auhjhwerty'+convert(varchar(5),@x)),('xcvbaq'+convert(varchar(5),@x)),('alkjhgfde'+convert(varchar(5),@x)),
 ('sauytre'+convert(varchar(5),@x)),('aatrewq'+convert(varchar(5),@x)),('azsdfghjk'+convert(varchar(5),@x)),
 ('axwertyuio'+convert(varchar(5),@x)),('achgfds'+convert(varchar(5),@x)),('hgrewab'+convert(varchar(5),@x))

  )
 select @x=@x+1
 END
 commit tran
 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 set nocount on
declare @x int 
declare @FromDate date = '2020-01-01'
declare @ToDate date = '2021-05-24'
select @x=5000001
begin tran
while @x<=5025001
begin 
 insert into latestdata (id,entry_date , c1 ,c2 ,c3 ,c4 
,c5 ,c6 ,c7 ,c8 ,c9 ,c10 ,c11 ,c12 
,c13 ,c14 ,c15 ,c16 ,c17 ,c18 ,c19 
,c20 ,c21 ,c22 ,c23 ,c24 ,c25 ,c26 
,c27 ,c28 ,c29 ,c30 ,c31 ,c32 ,c33 
,c34 ,c35 ,c36 ,c37 ,c38 ,c39 ,c40 
,c41 ,c42 ,c43 ,c44 ,c45 ,c46 ,c47 ,c48 )
 values((@x),
 ( dateadd(day, rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), @FromDate))
 ,('rqqqqqa'+convert(varchar(5),@x)),('adfghjr'+convert(varchar(5),@x)),('txczcza'+convert(varchar(5),@x)),
 ('asdadat'+convert(varchar(5),@x)),('iffsdfda'+convert(varchar(5),@x)),('afsffdfi'+convert(varchar(5),@x)),
 ('dfdfsda'+convert(varchar(5),@x)),('fsdfsdpa'+convert(varchar(5),@x)),('adfsfsp'+convert(varchar(5),@x)),
 ('sazvcv'+convert(varchar(5),@x)),('askjkjk'+convert(varchar(5),@x)),('dhjghna'+convert(varchar(5),@x)),
 ('asdwqcvvd'+convert(varchar(5),@x)),('fdfdfdvdvda'+convert(varchar(5),@x)),('advdvdfdff'+convert(varchar(5),@x)),
 ('gfgfgfvfva'+convert(varchar(5),@x)),('vnjyjhag'+convert(varchar(5),@x)),('ukujmha'+convert(varchar(5),@x)),
 ('ajhhnfrth'+convert(varchar(5),@x)),('jbrrvdva'+convert(varchar(5),@x)),('kwdwd3wda'+convert(varchar(5),@x)),
 ('aewddwdwk'+convert(varchar(5),@x)),('lefe3dsdwa'+convert(varchar(5),@x)),('fedredcal'+convert(varchar(5),@x)),
 ('acedf3en'+convert(varchar(5),@x)),('nasdfga'+convert(varchar(5),@x)),('voiuytrewa'+convert(varchar(5),@x)),
 ('x3tyuiojhgfa'+convert(varchar(5),@x)),('ertyuiuma'+convert(varchar(5),@x)),('fddfddcba'+convert(varchar(5),@x)),
 ('afdcerem'+convert(varchar(5),@x)),('bdfewertyua'+convert(varchar(5),@x)),('ksdfga'+convert(varchar(5),@x)),
 ('fjhgfdsa'+convert(varchar(5),@x)),('azxcvbo'+convert(varchar(5),@x)),('uytreaj'+convert(varchar(5),@x)),
 ('asdfghe'+convert(varchar(5),@x)),('rsdfgha'+convert(varchar(5),@x)),('3456gtfrewat'+convert(varchar(5),@x)),
 ('auhjhwerty'+convert(varchar(5),@x)),('xcvbaq'+convert(varchar(5),@x)),('alkjhgfde'+convert(varchar(5),@x)),
 ('sauytre'+convert(varchar(5),@x)),('aatrewq'+convert(varchar(5),@x)),('azsdfghjk'+convert(varchar(5),@x)),
 ('axwertyuio'+convert(varchar(5),@x)),('achgfds'+convert(varchar(5),@x)),('hgrewab'+convert(varchar(5),@x))

  )
 select @x=@x+1
 END
 commit tran
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



