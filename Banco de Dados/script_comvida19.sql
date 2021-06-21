create database Comvida19;
use Comvida19;

/*CRIAÇÃO DA TABELA REGIÃO*/
create table regiao(
	cod_reg numeric(1,0)  primary key,
	nome_reg varchar(12) not null
);

/*CRIAÇÃO DA TABELA ESTADO*/
create table estado(
 cod_est numeric(2,0)  primary key,
 uf_est char(2) not null,
 nome_est varchar(20) not null,
 cod_reg numeric(1,0) not null,
 constraint estado_cod_reg_fk foreign key(cod_reg) references regiao(cod_reg)
);

/*comment on table estado is 'TABELA DOS ESTADOS';
comment on column cod_est is 'COLUNA DO CÓDIGO DOS ESTADOS';
comment on column uf_est is 'COLUNA DA UNIDADE FEDERAL, SIGLA DO ESTADO';
comment on column nome_est is 'COLUNA DO NOME DO ESTADO';*/

/*CRIAÇÃO DA TABELA CIDADE*/

create table cidade(
  cod_cid int auto_increment primary key,
  nome_cid varchar(100) not null,
  cod_est numeric(2,0), 
  constraint cidade_cod_est_fk foreign key(cod_est) references estado(cod_est)
);
/*comment on table cidade is 'TABELA DAS CIDADES';
comment on column cod_cid is 'COLUNA DO C?DIGO DA CIDADE';
comment on column nome_cid is 'COLUNA DO NOME DA CIDADE';
comment on column cod_est is 'CHAVE ESTRANGEIRA LIGANDO A CHAVE PRIM?RIA DA TABELA ESTADO';
*/
/*CRIAÇÃO DA TABELA ENDEREÇO*/

create table endereco(
  cod_end int auto_increment primary key,
  rua_end varchar(50) not null,
  cep_end int not null,
  num_end varchar(5) not null, 
  comp_end varchar(100) not null, 
  bai_end varchar(50) not null, 
  cod_cid int,
  constraint endereco_cod_cid_fk foreign key(cod_cid) references cidade(cod_cid)
);

/*comment on table endereco is 'TABELA DO ENDEREÇO DO PACIENTE';
comment on column cod_end is 'COLUNA DO CÓDIGO DO ENDEREÇO';
comment on column rua_end is 'COLUNA DO NOME DA RUA DO ENDEREÇO';
*/
/*CRIAÇÃO DA TABELA TIPO_USUÁRIO*/

create table tipo_usu(
  cod_tipo_usu numeric(1,0)  primary key,
  desc_tipo_usu varchar(13) not null
);
select * from usuario u ;
select * from tipo_usu tu ;
/*CRIAÇÃO DA TABELA USUÁRIO*/

create table usuario(
 cod_usu int auto_increment primary key,
 email_usu varchar(80) unique not null,
 senha_usu varchar(30) not null,
 login_usu varchar(20) unique not null,
 cod_tipo_usu numeric(1,0) default 1,
 constraint usuario_cod_tipo_usu_tipo_usu_fk foreign key(cod_tipo_usu) references tipo_usu(cod_tipo_usu)
);

/*CRIAÇÃO DA TABELA PACIENTE*/
create table status(
	cod_status numeric(1,0) primary key,
	des_status varchar(12) not null
);
insert into status 
values(1,'Suspeito'),(2,'Confirmado'),(3,'Recuperado');

create table paciente(
  cod_pac int auto_increment primary key,
  nome_pac varchar(100) not null,
  alt_pac numeric(3,2) not null, 
  peso_pac numeric(5,2) not null,
  data_nasc_pac date not null, 
  gen_pac char(1) not null,
  cod_usu int not null,
  cod_end int not null,
  cod_status numeric(1,0) not null,
  constraint paciente_cod_usu_fk foreign key(cod_usu) references usuario(cod_usu),
  constraint paciente_cod_end_fk foreign key(cod_end) references endereco(cod_end),
  constraint paciente_cod_status_fk foreign key(cod_status) references status(cod_status)
);
select * from paciente p;

/*CRIAÇÃO DA TABELA TELEFONE*/

create table telefone(
  cod_tel int auto_increment primary key,
  num_tel int not null, 
  ddd_tel numeric(2,0) not null,
  cod_pac int not null, 
  constraint telefone_cod_pac_fk foreign key(cod_pac) references paciente(cod_pac)
);

/*CRIAÇÃO DA TABELA PRONTUARIO*/

create table prontuario(
  cod_pront int auto_increment primary key, 
  cod_pac int,
  constraint prontuario_cod_pac_fk foreign key(cod_pac) references paciente(cod_pac)
);

/*CRIAÇÃO DA TABELA INTENSIDADE*/

create table intensidade(
  cod_int numeric(1,0)  primary key,
  desc_int varchar(10) not null
);

/*CRIAÇÃO DA TABELA SINTOMAS*/

create table sintoma(
  cod_sin numeric(1,0)  primary key,
  desc_sin varchar(15) not null
);

/*CRIAÇÃO DA TABELA SINTOMAS_INTENSIDADE*/

create table sintoma_intensidade(
  cod_sin_int int auto_increment primary key,
  cod_int numeric(1,0),
  cod_sin numeric(1,0),
  cod_pront int,
  constraint sintoma_intensidade_cod_int_fk foreign key(cod_int) references intensidade(cod_int),
  constraint sintoma_intensidade_cod_sin_fk foreign key(cod_sin) references sintoma(cod_sin),
  constraint sintoma_intensidade_cod_pront_fk foreign key(cod_pront) references prontuario(cod_pront)
);


/*CRIAÇÃO DA TABELA COMORBIDADE*/

create table comorbidade(
  cod_como numeric(2,0)  primary key,
  desc_como varchar(60) not null
);

/*CRIAÇÃO DA TABELA PRONTUARIO_COMORBIDADE*/

create table prontuario_comorbidade(
  cod_pront_como int auto_increment primary key,
  cod_como numeric(2,0),
  cod_pront int,
  constraint prontuario_comorbidade_cod_como_fk foreign key(cod_como) references comorbidade(cod_como),
  constraint prontuario_comorbidade_cod_pront_fk foreign key(cod_pront) references prontuario(cod_pront)
);



select * from paciente p ;

/*Inserts*/

/*Inserindo dados na tabela sintoma*/
insert into sintoma(cod_sin,desc_sin)
values(1,'Febre'),(2,'Tosse'),(3,'Falta de ar'),(4,'Dor no corpo'),(5,'Dor de garganta'),(6,'Calafrio'),(7,'Dor muscular'),
(8,'Congestão nasal'),(9,'Coriza');

/*Inserindo dados na tabela intensidade*/
insert into intensidade(cod_int,desc_int)
values(1,'Pouco'),(2,'Moderado'),(3,'Constante');

/*****************CARGA TIPO_USUARIO**************/
insert into tipo_usu (cod_tipo_usu, desc_tipo_usu)  values (1, 'PACIENTE'),(2,'ADMINISTRADOR');

/***************CARGA NA REGIÃO************/
insert into regiao
values(1,'Norte'),(2,'Nordeste'),(3,'Centro-Oeste'),(4,'Sudeste'),(5,'Sul');




/******************CARGA ESTADO*****************/

insert into estado (cod_est, nome_est, uf_est,cod_reg) values (1, 'RIO GRANDE DO SUL', 'RS',5);
insert into estado (cod_est, nome_est, uf_est,cod_reg) values (2, 'SANTA CATARINA', 'SC',5);
insert into estado (cod_est, nome_est, uf_est,cod_reg) values (3, 'PARANÁ', 'PR',5);

/*************CARGA CIDADES***********/
insert into cidade(cod_cid,nome_cid,cod_est)
values(1,'São José do Cedro',2),(2,'Chápeco',2),(3,'Maravilha',2),(4,'Tenente Portela',1),(5,'Erechin',1),
(6,'Porto Alegre',1),(7,'Passo Fundo',1);


/***********PREENCHENDO DADOS FICTICIOS*********/



insert into usuario(cod_usu, email_usu,senha_usu,login_usu)
values(1,'PeJu@email.com','78251496','Pedro Ju'),
(2,'JoPaulo@email.com','210461','Joao P'),
(3,'Gabril@gmail.com','741891','Gabi01'),
(4,'victor@gmail.com','fnf824a','Victor09'),
(5,'sabrina01@gmail.com','255asd','sab01'),
(6,'angela@out.com','45daasd','angelaM'),
(7,'Gabriela@outl.com','wef8ef8','gabi145'),
(8,'bene@gmail.com','ztdj418','benedito'),
(9,'bernardo@gmail.com','89451wewe','bernardo999'),
(10,'julia01@gmail.com','TJZd584','julia01'),
(11,'silvia@outl.com','Uwh891','silia255'),
(12,'lucaser@gmail.com','uryr842','lucas123'),
(13,'marcosO@gmail.com','brtyu88548','MarcosO'),
(14,'Julio12@gmail.com','khjiklnh','Juio123'),
(15,'MarcosM@gmail.com','lkolk','MarcosM'),
(16,'Maria@gmail.com','ytrejnr','Maria24'),
(17,'Mirian213@gmail.com','213467895','Mirian44'),
(18,'Carla90@gmail.com','821457sdf','Carla55'),
(19,'Sabrina106@email.com','lomn7485','Sabrina70'),
(20,'Gilberto140@email.com','gilbsd','Gilberto8'),
(21,'Marcelo94@email.com','marft','Marcelo253'),
(22,'Juliano85@email.com','junsdf','Juliano251'),
(23,'Sandro130@email.com','sand85285','Sandro18'),
(24,'Beto34@email.com','8vxc5417','Beto169'),
(25,'Sandra253@email.com','5fr','Sandra96'),
(26,'Vinicius231@email.com','7418dsf5s','Vinicius119'),
(27,'Giuliano157@email.com','sdfsfewr','Giuliano213'),
(28,'Marcos127@email.com','hthegq','Marcos37'),
(29,'Gilberto88@email.com','ghqGAW','Gilberto56'),
(30,'Sandro209@email.com','Gath','Sandro4'),
(31,'Juliano217@email.com','4147923','Juliano226'),
(32,'Sabrina17@email.com','dfgher','Sabrina117'),
(33,'Marcia77@email.com','58866g5dfg','Marcia229'),
(34,'Maria Clara243@email.com','jgv548','Maria Clara71'),
(35,'Clara229@email.com','854684rt','Clara89'),
(36,'Erene58@email.com','uigyf6vuy','Erene196'),
(37,'Estefano39@email.com','db888','Estefano248'),
(38,'Juliano138@email.com','748518','Juliano58'),
(39,'Miguel185@email.com','894568','Miguel48'),
(40,'Marcos178@email.com','ilgjtyj','Marcos4'),
(41,'Marcelo73@email.com','hkjyj','Marcelo181'),
(42,'Silvia234@email.com','yjdsrt','Silvia252'),
(43,'Angelica233@email.com','12451','Angelica247'),
(44,'Maria Clara151@email.com','784875','Maria Clara92'),
(45,'Amanda125@email.com','78457','Amanda254'),
(46,'Gilvana211@email.com','748dsf','Gilvana106'),
(47,'Sandra209@email.com','sdfer','Sandra30');


insert into endereco
values (1,'Principal158',56261924,'1087','Ap.967','centro',1),
(2,'Principal71',82667870,'606','Ap.76','centro',1),
(3,'Principal161',66643759,'139','Ap.527','centro',1),
(4,'Principal92',64345507,'1176','Ap.511','centro',1),
(5,'Principal12',82208893,'1564','Ap.233','centro',1),
(6,'Principal66',35112082,'532','Ap.93','centro',1),
(7,'Principal80',36052691,'1298','Ap.998','Costeira',3),
(8,'Principal34',36927002,'421','Ap.381','Costeira',3),
(9,'Principal184',45822874,'18','Ap.682','Costeira',3),
(10,'Principal22',60435555,'120','Ap.925','centro',3),
(11,'Principal75',11204301,'1251','Ap.928','centro',3),
(12,'Principal162',91863710,'1636','Ap.326','centro',3),
(13,'Principal25',34119400,'1005','Ap.435','centro',3),
(14,'Principal146',55798987,'1206','Ap.272','centro',2),
(15,'Principal68',68750337,'1641','Ap.22','centro',2),
(16,'segunda93',36369727,'1480','Ap.476','centro',2),
(17,'segunda6',13660516,'1642','Ap.174','centro',2),
(18,'segunda188',90457853,'362','Ap.406','centro',2),
(19,'segunda2',75304920,'325','Ap.711','Meia Volta',2),
(20,'segunda81',95452636,'146','Ap.288','Meia Volta',2),
(21,'segunda96',98247373,'16','Ap.287','Meia Volta',2),
(22,'segunda100',81525566,'823','Ap.311','Meia Volta',2),
(23,'segunda15',51481531,'907','Ap.404','centro',2),
(24,'segunda119',24226415,'295','Ap.896','centro',2),
(25,'segunda141',14263801,'172','Ap.864','centro',6),
(26,'Fagundes130',74964157,'1284','Ap.950','Jardin',6),
(27,'Fagundes150',53087635,'1969','Ap.408','Jardin',6),
(28,'Fagundes150',46780731,'1932','Ap.367','Jardin',6),
(29,'Fagundes70',78872255,'355','Ap.104','Jardin',4),
(30,'Fagundes74',72882928,'221','Ap.105','Jardin',4),
(31,'Fagundes190',86862318,'1692','Ap.183','Jardin',4),
(32,'Fagundes94',48244423,'944','Ap.555','Jardin',4),
(33,'Fagundes48',26210481,'1153','Ap.846','Jardin',4),
(34,'Fagundes44',37928758,'1333','Ap.102','centro',5),
(35,'Fagundes142',95951449,'1556','Ap.145','centro',5),
(36,'Fagundes171',12242110,'1833','Ap.979','centro',5),
(37,'Fagundes177',11686053,'1335','Ap.279','centro',5),
(38,'Fagundes84',27124367,'102','Ap.486','Baruiri',5),
(39,'Euclides167',49026458,'506','Ap.941','Baruiri',5),
(40,'Euclides73',47505765,'1787','Ap.262','Baruiri',5),
(41,'Euclides167',68101602,'1857','Ap.396','centro',5),
(42,'Euclides22',72065782,'970','Ap.282','centro',7),
(43,'Euclides49',40606446,'398','Ap.915','centro',7),
(44,'Euclides8',83731913,'501','Ap.535','centro',7),
(45,'Euclides157',45822757,'856','Ap.949','Tramontina',7),
(46,'Euclides169',26351651,'544','Ap.534','Tramontina',7),
(47,'Euclides60',73950098,'1026','Ap.885','Tramontina',7);



insert into paciente(cod_pac,nome_pac,alt_pac,peso_pac,data_nasc_pac,gen_pac,cod_usu,cod_end,cod_status)
values(1,'Pedro Juliano',1.76,78.20,'2002-6-1','M',1,1,1),
(2,'João Paulo',1.75,75.20,'1990-5-13','M',2,2,1),
(3,'Gabriel',1.89,89.3,'1996-4-11','M',3,3,1),
(4,'Victor',1.79,79.9,'2001-2-20','M',4,4,1),
(5,'Sabrina',1.75,65.2,'1997-5-6','F',5,5,1),
(6,'Angela',1.73,64,'2000-5-4','F',6,6,1),
(7,'Gabriela',1.68,59.3,'1997-8-9','F',7,7,1),
(8,'Benedito',1.79,70.5,'1990-5-15','M',8,8,1),
(9,'Bernardo',1.71,100.3,'1990-3-27','M',9,9,1),
(10,'Julia',1.80,76.2,'2000-4-27','F',10,10,1),
(11,'Silvia',1.69,81.1,'1990-3-9','F',11,11,1),
(12,'Lucas',1.82,85.3,'1991-2-10','M',12,12,1),
(13,'Marcos',1.78,81.2,'1992-7-12','M',13,13,1),
(14,'Julio',1.80,84.5,'1993-11-1','M',14,14,1),
(15,'Marcos',1.76,79,'1993-6-15','M',15,15,2),
(16,'Maria',1.64,58.9,'1999-5-19','F',16,16,2),
(17,'Miriam',1.71,75.20,'1990-7-13','F',17,17,2),
(18,'Carla',1.79,81.1,'1994-9-26','F',18,18,2),
(19,'Sabrina',1.64,70.5,'1999-7-7','F',19,19,2),
(20,'Gilberto',1.82,89.3,'1990-10-20','M',20,20,2),
(21,'Marcelo',1.78,86.30,'1996-11-19','M',21,21,2),
(22,'Juliano',1.81,89.6,'1992-4-28','M',22,22,2),
(23,'Sandro',1.76,79.5,'1996-7-1','M',23,23,2),
(24,'Beto',1.69,69,'1992-2-13','M',24,24,2),
(25,'Sandra',1.79,82,'1998-2-21','M',25,25,2),
(26,'Vinicius',1.79,86.30,'1993-7-18','M',26,26,2),
(27,'Giuliano',1.75,85.30,'1992-1-14','M',27,27,2),
(28,'Marcos',1.69,68,'1994-5-16','M',28,28,2),
(29,'Gilberto',1.64,70.5,'1993-1-13','M',29,29,2),
(30,'Sandro',1.81,89.8,'1994-6-9','M',30,30,2),
(31,'Juliano',1.79,79.5,'2001-8-15','M',31,31,2),
(32,'Sabrina',1.76,86.4,'2002-9-12','F',32,32,2),
(33,'Marcia',1.69,75.20,'1995-4-10','F',33,33,3),
(34,'Maria Clara',1.79,78.20,'1999-11-6','F',34,34,3),
(35,'Clara',1.69,68.3,'2002-3-17','F',35,35,3),
(36,'Erene',1.69,64,'1993-3-20','F',36,36,3),
(37,'Estefano',1.79,86.5,'1999-8-26','M',37,37,3),
(38,'Juliano',1.82,98.6,'1994-1-24','M',38,38,3),
(39,'Miguel',1.79,85.3,'1999-3-9','M',39,39,3),
(40,'Marcos',1.79,83,'1998-4-1','M',40,40,3),
(41,'Marcelo',1.72,72,'1997-8-7','M',41,41,3),
(42,'Silvia',1.79,74,'1996-3-3','F',42,42,3),
(43,'Angelica',1.59,52,'1995-10-15','F',43,43,3),
(44,'Maria Clara',1.71,71,'1998-4-12','F',44,44,3),
(45,'Amanda',1.68,63,'1994-3-7','F',45,45,3),
(46,'Gilvana',1.58,52.1,'1996-4-22','F',46,46,3),
(47,'Sandra',1.75,76.2,'1992-3-13','F',47,47,3);






insert into prontuario
values(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20),
(21,21),
(22,22),
(23,23),
(24,24),
(25,25),
(26,26),
(27,27),
(28,28),
(29,29),
(30,30),
(31,31),
(32,32),
(33,33),
(34,34),
(35,35),
(36,36),
(37,37),
(38,38),
(39,39),
(40,40),
(41,41),
(42,42),
(43,43),
(44,44),
(45,45),
(46,46),
(47,47);

insert into comorbidade
values(1,'Nefropatias'),(2,'Hepatopatias'),(3,'Diabetes'),(4,'Obesidade'),(5,'Transtornos Neurológicos'),(6,'Imunossupressos'),
(7,'Doenças cardíacas crônica');


select * from sintoma_intensidade si;
insert into sintoma_intensidade(cod_sin_int,cod_sin,cod_int,cod_pront)
values (1,2,1,1),
(2,1,2,1),
(4,5,2,2),
(5,6,2,2),
(7,7,1,3),
(8,6,1,3),
(9,9,1,3),
(10,8,1,3),
(12,1,1,4),
(13,2,1,4),
(14,4,2,4),
(16,6,1,5),
(17,9,2,5),
(18,8,2,5),
(20,1,2,6),
(21,2,2,6),
(22,4,2,6),
(24,4,1,7),
(25,7,1,7),
(27,1,2,8),
(29,9,2,9),
(30,8,2,9),
(32,4,1,10),
(33,7,1,10),
(35,3,1,11),
(37,3,3,12),
(38,2,3,12),
(40,4,1,13),
(41,6,1,13),
(42,7,1,13),
(43,5,1,13),
(45,2,1,14),
(46,1,1,14),
(47,9,3,14),
(48,4,2,14),
(50,2,1,15),
(51,3,1,15),
(53,2,2,16),
(54,1,2,16),
(55,9,2,16),
(56,4,2,16),
(58,9,2,17),
(60,8,1,18),
(61,1,2,18),
(63,4,1,19),
(65,5,2,20),
(66,6,2,20),
(68,7,1,21),
(69,4,1,21),
(71,9,2,22),
(72,2,2,22),
(73,8,2,22),
(74,1,1,22),
(75,6,1,22),
(77,7,2,23),
(78,5,1,23),
(79,4,1,23),
(80,3,1,23),
(81,2,1,23),
(83,2,1,24),
(85,2,2,25),
(86,9,2,25),
(88,5,1,26),
(90,8,1,27),
(91,1,2,27),
(93,3,1,28),
(94,2,1,28),
(96,9,2,29),
(97,2,3,29),
(98,1,2,29),
(100,5,2,30),
(102,5,1,31),
(103,6,2,31),
(105,2,1,32),
(106,9,1,32),
(107,1,1,32),
(109,6,3,33),
(111,7,1,34),
(112,3,1,34),
(113,2,1,34),
(114,9,1,34),
(115,1,1,34),
(117,2,2,35),
(119,8,1,36),
(120,9,3,36),
(122,9,1,37),
(123,1,2,37),
(124,5,2,37),
(126,5,2,38),
(127,6,2,38),
(129,6,2,39),
(130,7,1,39),
(131,3,1,39),
(133,1,1,40),
(134,6,1,40),
(135,2,2,40),
(136,3,2,40),
(137,8,2,40),
(139,7,1,41),
(140,6,1,41),
(141,1,1,41),
(142,8,1,41),
(143,9,2,41),
(145,3,2,42),
(146,8,2,42),
(148,2,2,43),
(149,7,2,43),
(150,1,1,43),
(151,6,1,43),
(153,8,2,44),
(154,2,2,44),
(155,7,2,44),
(156,9,1,44),
(157,3,2,44),
(159,9,1,45),
(160,1,1,45),
(161,6,1,45),
(162,8,1,45),
(164,2,1,46),
(165,3,1,46),
(166,1,1,46),
(168,7,3,47),
(169,6,2,47),
(170,3,3,47),
(171,2,3,47);

insert into prontuario_comorbidade(cod_pront,cod_como)
values(5,1),
(6,2),
(9,3),
(9,4),
(10,5),
(11,1),
(14,6),
(14,1),
(17,1),
(20,2),
(23,2),
(23,1),
(23,6),
(24,6),
(26,6),
(28,1),
(29,1),
(35,1),
(38,2),
(39,3),
(39,6),
(40,6),
(40,1),
(41,4),
(41,1),
(41,2),
(42,5),
(47,4),
(47,1);


create table faq(
	cod_faq int auto_increment primary key,
	per_faq varchar(120),
	res_faq varchar(2000)
);

insert into faq(per_faq,res_faq)
values('O que é o novo coronavírus?','O nCoV é uma nova cepa de coronavírus que não havia sido previamente identificada em humanos.'),
('Qual é a definição de caso suspeito?','O caso suspeito apresenta febre acompanhada de sintomas respiratórios, além de atender a uma 
das duas seguintes situações: (a) ter viajado nos últimos 14 dias antes do início dos sintomas para área de transmissão local ou
 (b) ter tido contato próximo com casos suspeitos ou confirmados. Febre pode não estar presente em alguns pacientes, como idosos,
 imunocomprometidos ou que tenham utilizado antitérmicos.'),
 ('Qual é a orientação diante da detecção de caso suspeito?','Os casos suspeitos
 devem ser mantidos em isolamento enquanto houver sinais e sintomas clínicos. Pacientes devem utilizar máscara cirúrgica a partir do momento 
da suspeita e ser mantido preferencialmente em quarto privativo. Profissionais da saúde devem utilizar medidas de precaução padrão, de contato
 e de gotículas (máscara cirúrgica, luvas, avental não estéril e óculos de proteção). Para a realização de procedimentos que gerem aerossolização 
de secreções respiratórias, como intubação, aspiração de vias aéreas ou indução de escarro, deverá ser utilizada precaução por aerossóis, com uso 
de máscara profissional PFF2 (N95). Estas são recomendações atuais do Ministério da Saúde.'),
('Qual é o período de incubação desta nova variante do coronavírus?','Ainda não há uma informação exata. Presume-se que o tempo de exposição ao vírus 
e o início dos sintomas seja de até duas semanas, sendo que na maioria dos casos os sintomas aparecem entre o 5º. e 9º. dia após infecção.');




insert into estado
values
(4,'SP','São Paulo',4),(5,'RJ','Rio de Janeiro',4),(6,'MT','Mato Grosso',3),(7,'MS','Mato Grosso do Sul',3),(8,'AC','Acre',1),
(9,'AM','Amazonas',1),(10,'BA','Bahia',2),(11,'PE','Pernambuco',2);

insert into cidade 
values(8,'Guarulhos',4),(9,'Osasco',4),(10,'Santo André',4),
(11,'Niterói',5),(12,'Nova Iguaçu',5),(13,'Cabo Frio',5),(14,'Angra dos Reis',5),
(15,'Acorizal',6),(16,'Alto Boa Vista',6),(17,'Alcinópolis',7),(18,'Água Clara',7),
(19,'Capixaba',8),(20,'Manoel Urbano',8),(21,'Porto Acre',8),(22,'Rio Branco',8),
(23,'Atalaia do Norte',9),(24,'Autazes',9),
(25,'Porto Seguro',10),(26,'Alagoinhas',10),(27,'Ilhéus',10),
(28,'Barreiros',11),(29,'Belo Jardim',11);





select count(*) as "total suspeitos" from paciente p 
inner join status s on p.cod_status = s.cod_status
where s.des_status = 'Suspeito';

select count(*) as "total Confirmados" from paciente p 
inner join status s on s.cod_status = p.cod_status
where s.des_status = 'Confirmado';

select count(*) as "total Recuperados" from paciente p 
inner join status s on s.cod_status = p.cod_status
where s.des_status = 'Recuperado';

select count(*) as "total suspeitos do sul" from paciente p 
inner join status s on s.cod_status = p.cod_status
inner join endereco e on e.cod_end = p.cod_end
inner join cidade c on c.cod_cid = e.cod_cid 
inner join estado es on es.cod_est = c.cod_est 
inner join regiao re on re.cod_reg = es.cod_reg 
where s.des_status = 'Suspeito' and re.nome_reg = 'Sul';

select count(*) as "total confirmado do sul" from paciente p 
inner join status s on s.cod_status = p.cod_status
inner join endereco e on e.cod_end = p.cod_end
inner join cidade c on c.cod_cid = e.cod_cid 
inner join estado es on es.cod_est = c.cod_est 
inner join regiao re on re.cod_reg = es.cod_reg 
where s.des_status = 'Confirmado' and re.nome_reg = 'Sul';


select count(*) as "total recuperados do sul" from paciente p 
inner join status s on s.cod_status = p.cod_status
inner join endereco e on e.cod_end = p.cod_end
inner join cidade c on c.cod_cid = e.cod_cid 
inner join estado es on es.cod_est = c.cod_est 
inner join regiao re on re.cod_reg = es.cod_reg 
where s.des_status = 'Recuperado' and re.nome_reg = 'Sul';

create or replace view tela_info_vw as
select pac.cod_usu,pac.nome_pac,pac.alt_pac,pac.peso_pac,pac.data_nasc_pac,pac.gen_pac,e.rua_end,e.num_end,e.comp_end,e.bai_end,c.nome_cid,es.nome_est 
from paciente pac
inner join endereco e on pac.cod_end = e.cod_end 
inner join cidade c on c.cod_cid = e.cod_cid 
inner join estado es on es.cod_est = c.cod_est ;