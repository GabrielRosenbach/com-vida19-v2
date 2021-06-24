create database Comvida19;
use Comvida19;

/*CRIA??O DA TABELA REGI?O*/
create table regiao(
	cod_reg numeric(1,0)  primary key,
	nome_reg varchar(12) not null
);

/*CRIA??O DA TABELA ESTADO*/
create table estado(
 cod_est numeric(2,0)  primary key,
 uf_est char(2) not null,
 nome_est varchar(20) not null,
 cod_reg numeric(1,0) not null,
 constraint estado_cod_reg_fk foreign key(cod_reg) references regiao(cod_reg)
);

/*comment on table estado is 'TABELA DOS ESTADOS';
comment on column cod_est is 'COLUNA DO C?DIGO DOS ESTADOS';
comment on column uf_est is 'COLUNA DA UNIDADE FEDERAL, SIGLA DO ESTADO';
comment on column nome_est is 'COLUNA DO NOME DO ESTADO';*/

/*CRIA??O DA TABELA CIDADE*/

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
/*CRIA??O DA TABELA ENDERE?O*/



/*comment on table endereco is 'TABELA DO ENDERE?O DO PACIENTE';
comment on column cod_end is 'COLUNA DO C?DIGO DO ENDERE?O';
comment on column rua_end is 'COLUNA DO NOME DA RUA DO ENDERE?O';
*/
/*CRIA??O DA TABELA TIPO_USU?RIO*/

create table tipo_usu(
  cod_tipo_usu numeric(1,0)  primary key,
  desc_tipo_usu varchar(13) not null
);

/*CRIA??O DA TABELA USU?RIO*/

create table usuario(
 cod_usu int auto_increment primary key,
 email_usu varchar(80) unique not null,
 senha_usu varchar(30) not null,
 login_usu varchar(20) unique not null,
 cod_tipo_usu numeric(1,0) default 1,
 constraint usuario_cod_tipo_usu_tipo_usu_fk foreign key(cod_tipo_usu) references tipo_usu(cod_tipo_usu)
);

/*CRIA??O DA TABELA PACIENTE*/
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
  cod_status numeric(1,0),
  constraint gen_pac_chk check (gen_pac='M' or gen_pac = 'F'),
  constraint paciente_cod_usu_fk foreign key(cod_usu) references usuario(cod_usu),
  constraint paciente_cod_status_fk foreign key(cod_status) references status(cod_status)
);
create table endereco(
  cod_end int auto_increment primary key,
  rua_end varchar(50) not null,
  num_end varchar(5) not null, 
  comp_end varchar(100) not null, 
  bai_end varchar(50) not null, 
  cod_cid int not null,
  cod_pac int not null,
  constraint endereco_cod_cid_fk foreign key(cod_cid) references cidade(cod_cid),
  constraint endereco_cod_pac_fk foreign key(cod_pac) references paciente(cod_pac)
);
/*CRIA??O DA TABELA TELEFONE*/

create table telefone(
  cod_tel int auto_increment primary key,
  num_tel int not null, 
  ddd_tel numeric(2,0) not null,
  cod_pac int not null, 
  constraint telefone_cod_pac_fk foreign key(cod_pac) references paciente(cod_pac)
);

/*CRIA??O DA TABELA PRONTUARIO*/

create table prontuario(
  cod_pront int auto_increment primary key, 
  cod_pac int,
  constraint prontuario_cod_pac_fk foreign key(cod_pac) references paciente(cod_pac)
);

/*CRIA??O DA TABELA INTENSIDADE*/

create table intensidade(
  cod_int numeric(1,0)  primary key,
  desc_int varchar(10) not null
);

/*CRIA??O DA TABELA SINTOMAS*/

create table sintoma(
  cod_sin numeric(2,0)  primary key,
  desc_sin varchar(30) not null
);

/*CRIA??O DA TABELA SINTOMAS_INTENSIDADE*/

create table sintoma_intensidade(
  cod_sin_int int auto_increment primary key,
  cod_int numeric(1,0),
  cod_sin numeric(2,0),
  cod_pront int,
  constraint sintoma_intensidade_cod_int_fk foreign key(cod_int) references intensidade(cod_int),
  constraint sintoma_intensidade_cod_sin_fk foreign key(cod_sin) references sintoma(cod_sin),
  constraint sintoma_intensidade_cod_pront_fk foreign key(cod_pront) references prontuario(cod_pront)
);


/*CRIA??O DA TABELA COMORBIDADE*/

create table comorbidade(
  cod_como numeric(2,0)  primary key,
  desc_como varchar(60) not null
);

/*CRIA??O DA TABELA PRONTUARIO_COMORBIDADE*/

create table prontuario_comorbidade(
  cod_pront_como int auto_increment primary key,
  cod_como numeric(2,0),
  cod_pront int,
  constraint prontuario_comorbidade_cod_como_fk foreign key(cod_como) references comorbidade(cod_como),
  constraint prontuario_comorbidade_cod_pront_fk foreign key(cod_pront) references prontuario(cod_pront)
);




/*Inserts*/

/*Inserindo dados na tabela sintoma*/
insert into sintoma(cod_sin,desc_sin)
values(1,'Febre'),(2,'Tosse'),(3,'Falta de ar'),(4,'Dor no corpo'),(5,'Dor de garganta'),(6,'Calafrio'),(7,'Dor muscular'),
(8,'Congest?o nasal'),(9,'Coriza'),(10,'Cansa?o'),(11,'Diarreia'),(12,'Conjuntivite'),(13,'Perda de Paladar ou Olfato'),
(14,'Perda de Fala ou Movimento');

/*Inserindo dados na tabela intensidade*/
insert into intensidade(cod_int,desc_int)
values(1,'Pouco'),(2,'Moderado'),(3,'Constante');

/*****************CARGA TIPO_USUARIO**************/
insert into tipo_usu (cod_tipo_usu, desc_tipo_usu)  values (1, 'PACIENTE'),(2,'ADMINISTRADOR');

/***************CARGA NA REGI?O************/

Insert into regiao values (1, 'Norte');
Insert into regiao values (2, 'Nordeste');
Insert into regiao values (3, 'Sudeste');
Insert into regiao values (4, 'Sul');
Insert into regiao values (5, 'Centro-Oeste');



/******************CARGA ESTADO*****************/

Insert into Estado (cod_est, nome_est, uf_est, cod_reg)
values (12, 'Acre', 'AC', 1),
 (27, 'Alagoas', 'AL', 2),
 (16, 'Amap?', 'AP', 1),
 (13, 'Amazonas', 'AM', 1),
 (29, 'Bahia', 'BA', 2),
 (23, 'Cear?', 'CE', 2),
 (53, 'Distrito Federal', 'DF', 5),
 (32, 'Esp?rito Santo', 'ES', 3),
 (52, 'Goi?s', 'GO', 5),
 (21, 'Maranh?o', 'MA', 2),
 (51, 'Mato Grosso', 'MT', 5),
 (50, 'Mato Grosso do Sul', 'MS', 5),
 (31, 'Minas Gerais', 'MG', 3),
 (15, 'Par?', 'PA', 1),
 (25, 'Para?ba', 'PB', 2),
 (41, 'Paran?', 'PR', 4),
 (26, 'Pernambuco', 'PE', 2),
 (22, 'Piau?', 'PI', 2),
 (33, 'Rio de Janeiro', 'RJ', 3),
 (24, 'Rio Grande do Norte', 'RN', 2),
 (43, 'Rio Grande do Sul', 'RS', 4),
 (11, 'Rond?nia', 'RO', 1),
 (14, 'Roraima', 'RR', 1),
 (42, 'Santa Catarina', 'SC', 4),
 (35, 'S?o Paulo', 'SP', 3),
 (28, 'Sergipe', 'SE', 2),
 (17, 'Tocantins', 'TO', 1);


/*************CARGA CIDADES***********/
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100015','Alta Floresta D''Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100023','Ariquemes', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100031','Cabixi', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100049','Cacoal', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100056','Cerejeiras', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100064','Colorado do Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100072','Corumbiara', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100080','Costa Marques', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100098','Espig?o D''Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100106','Guajar?-Mirim', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100114','Jaru', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100122','Ji-Paran?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100130','Machadinho D''Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100148','Nova Brasil?ndia D''Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100155','Ouro Preto do Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100189','Pimenta Bueno', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100205','Porto Velho', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100254','Presidente M?dici', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100262','Rio Crespo', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100288','Rolim de Moura', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100296','Santa Luzia D''Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100304','Vilhena', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100320','S?o Miguel do Guapor?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100338','Nova Mamor?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100346','Alvorada D''Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100379','Alto Alegre dos Parecis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100403','Alto Para?so', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100452','Buritis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100502','Novo Horizonte do Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100601','Cacaul?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100700','Campo Novo de Rond?nia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100809','Candeias do Jamari', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100908','Castanheiras', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100924','Chupinguaia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1100940','Cujubim', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101005','Governador Jorge Teixeira', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101104','Itapu? do Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101203','Ministro Andreazza', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101302','Mirante da Serra', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101401','Monte Negro', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101435','Nova Uni?o', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101450','Parecis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101468','Pimenteiras do Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101476','Primavera de Rond?nia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101484','S?o Felipe D''Oeste', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101492','S?o Francisco do Guapor?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101500','Seringueiras', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101559','Teixeir?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101609','Theobroma', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101708','Urup?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101757','Vale do Anari', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1101807','Vale do Para?so', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200013','Acrel?ndia', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200054','Assis Brasil', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200104','Brasil?ia', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200138','Bujari', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200179','Capixaba', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200203','Cruzeiro do Sul', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200252','Epitaciol?ndia', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200302','Feij?', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200328','Jord?o', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200336','M?ncio Lima', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200344','Manoel Urbano', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200351','Marechal Thaumaturgo', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200385','Pl?cido de Castro', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200393','Porto Walter', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200401','Rio Branco', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200427','Rodrigues Alves', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200435','Santa Rosa do Purus', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200450','Senador Guiomard', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200500','Sena Madureira', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200609','Tarauac?', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200708','Xapuri', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1200807','Porto Acre', 12);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300029','Alvar?es', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300060','Amatur?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300086','Anam?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300102','Anori', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300144','Apu?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300201','Atalaia do Norte', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300300','Autazes', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300409','Barcelos', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300508','Barreirinha', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300607','Benjamin Constant', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300631','Beruri', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300680','Boa Vista do Ramos', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300706','Boca do Acre', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300805','Borba', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300839','Caapiranga', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1300904','Canutama', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301001','Carauari', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301100','Careiro', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301159','Careiro da V?rzea', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301209','Coari', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301308','Codaj?s', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301407','Eirunep?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301506','Envira', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301605','Fonte Boa', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301654','Guajar?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301704','Humait?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301803','Ipixuna', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301852','Iranduba', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301902','Itacoatiara', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1301951','Itamarati', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302009','Itapiranga', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302108','Japur?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302207','Juru?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302306','Juta?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302405','L?brea', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302504','Manacapuru', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302553','Manaquiri', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302603','Manaus', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302702','Manicor?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302801','Mara?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1302900','Mau?s', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303007','Nhamund?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303106','Nova Olinda do Norte', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303205','Novo Air?o', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303304','Novo Aripuan?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303403','Parintins', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303502','Pauini', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303536','Presidente Figueiredo', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303569','Rio Preto da Eva', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303601','Santa Isabel do Rio Negro', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303700','Santo Ant?nio do I??', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303809','S?o Gabriel da Cachoeira', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303908','S?o Paulo de Oliven?a', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1303957','S?o Sebasti?o do Uatum?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1304005','Silves', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1304062','Tabatinga', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1304104','Tapau?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1304203','Tef?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1304237','Tonantins', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1304260','Uarini', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1304302','Urucar?', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1304401','Urucurituba', 13);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400027','Amajari', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400050','Alto Alegre', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400100','Boa Vista', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400159','Bonfim', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400175','Cant?', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400209','Caracara?', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400233','Caroebe', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400282','Iracema', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400308','Mucaja?', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400407','Normandia', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400456','Pacaraima', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400472','Rorain?polis', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400506','S?o Jo?o da Baliza', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400605','S?o Luiz', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1400704','Uiramut?', 14);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500107','Abaetetuba', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500131','Abel Figueiredo', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500206','Acar?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500305','Afu?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500347','?gua Azul do Norte', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500404','Alenquer', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500503','Almeirim', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500602','Altamira', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500701','Anaj?s', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500800','Ananindeua', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500859','Anapu', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500909','Augusto Corr?a', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1500958','Aurora do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501006','Aveiro', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501105','Bagre', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501204','Bai?o', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501253','Bannach', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501303','Barcarena', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501402','Bel?m', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501451','Belterra', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501501','Benevides', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501576','Bom Jesus do Tocantins', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501600','Bonito', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501709','Bragan?a', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501725','Brasil Novo', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501758','Brejo Grande do Araguaia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501782','Breu Branco', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501808','Breves', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501907','Bujaru', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1501956','Cachoeira do Piri?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502004','Cachoeira do Arari', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502103','Camet?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502152','Cana? dos Caraj?s', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502202','Capanema', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502301','Capit?o Po?o', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502400','Castanhal', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502509','Chaves', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502608','Colares', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502707','Concei??o do Araguaia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502756','Conc?rdia do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502764','Cumaru do Norte', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502772','Curion?polis', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502806','Curralinho', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502855','Curu?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502905','Curu??', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502939','Dom Eliseu', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1502954','Eldorado dos Caraj?s', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503002','Faro', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503044','Floresta do Araguaia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503077','Garraf?o do Norte', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503093','Goian?sia do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503101','Gurup?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503200','Igarap?-A?u', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503309','Igarap?-Miri', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503408','Inhangapi', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503457','Ipixuna do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503507','Irituia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503606','Itaituba', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503705','Itupiranga', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503754','Jacareacanga', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503804','Jacund?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1503903','Juruti', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504000','Limoeiro do Ajuru', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504059','M?e do Rio', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504109','Magalh?es Barata', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504208','Marab?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504307','Maracan?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504406','Marapanim', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504422','Marituba', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504455','Medicil?ndia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504505','Melga?o', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504604','Mocajuba', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504703','Moju', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504752','Moju? dos Campos', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504802','Monte Alegre', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504901','Muan?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504950','Nova Esperan?a do Piri?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1504976','Nova Ipixuna', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505007','Nova Timboteua', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505031','Novo Progresso', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505064','Novo Repartimento', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505106','?bidos', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505205','Oeiras do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505304','Oriximin?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505403','Our?m', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505437','Ouril?ndia do Norte', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505486','Pacaj?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505494','Palestina do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505502','Paragominas', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505536','Parauapebas', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505551','Pau D''Arco', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505601','Peixe-Boi', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505635','Pi?arra', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505650','Placas', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505700','Ponta de Pedras', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505809','Portel', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1505908','Porto de Moz', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506005','Prainha', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506104','Primavera', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506112','Quatipuru', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506138','Reden??o', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506161','Rio Maria', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506187','Rondon do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506195','Rur?polis', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506203','Salin?polis', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506302','Salvaterra', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506351','Santa B?rbara do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506401','Santa Cruz do Arari', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506500','Santa Isabel do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506559','Santa Luzia do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506583','Santa Maria das Barreiras', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506609','Santa Maria do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506708','Santana do Araguaia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506807','Santar?m', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1506906','Santar?m Novo', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507003','Santo Ant?nio do Tau?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507102','S?o Caetano de Odivelas', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507151','S?o Domingos do Araguaia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507201','S?o Domingos do Capim', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507300','S?o F?lix do Xingu', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507409','S?o Francisco do Par?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507458','S?o Geraldo do Araguaia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507466','S?o Jo?o da Ponta', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507474','S?o Jo?o de Pirabas', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507508','S?o Jo?o do Araguaia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507607','S?o Miguel do Guam?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507706','S?o Sebasti?o da Boa Vista', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507755','Sapucaia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507805','Senador Jos? Porf?rio', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507904','Soure', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507953','Tail?ndia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507961','Terra Alta', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1507979','Terra Santa', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508001','Tom?-A?u', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508035','Tracuateua', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508050','Trair?o', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508084','Tucum?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508100','Tucuru?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508126','Ulian?polis', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508159','Uruar?', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508209','Vigia', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508308','Viseu', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508357','Vit?ria do Xingu', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1508407','Xinguara', 15);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600055','Serra do Navio', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600105','Amap?', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600154','Pedra Branca do Amapari', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600204','Cal?oene', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600212','Cutias', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600238','Ferreira Gomes', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600253','Itaubal', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600279','Laranjal do Jari', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600303','Macap?', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600402','Mazag?o', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600501','Oiapoque', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600535','Porto Grande', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600550','Pracu?ba', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600600','Santana', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600709','Tartarugalzinho', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1600808','Vit?ria do Jari', 16);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1700251','Abreul?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1700301','Aguiarn?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1700350','Alian?a do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1700400','Almas', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1700707','Alvorada', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1701002','Anan?s', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1701051','Angico', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1701101','Aparecida do Rio Negro', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1701309','Aragominas', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1701903','Araguacema', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702000','Aragua?u', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702109','Aragua?na', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702158','Araguan?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702208','Araguatins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702307','Arapoema', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702406','Arraias', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702554','Augustin?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702703','Aurora do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1702901','Axix? do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703008','Baba?ul?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703057','Bandeirantes do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703073','Barra do Ouro', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703107','Barrol?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703206','Bernardo Say?o', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703305','Bom Jesus do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703602','Brasil?ndia do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703701','Brejinho de Nazar?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703800','Buriti do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703826','Cachoeirinha', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703842','Campos Lindos', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703867','Cariri do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703883','Carmol?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703891','Carrasco Bonito', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1703909','Caseara', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1704105','Centen?rio', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1704600','Chapada de Areia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1705102','Chapada da Natividade', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1705508','Colinas do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1705557','Combinado', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1705607','Concei??o do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1706001','Couto Magalh?es', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1706100','Cristal?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1706258','Crix?s do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1706506','Darcin?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1707009','Dian?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1707108','Divin?polis do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1707207','Dois Irm?os do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1707306','Duer?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1707405','Esperantina', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1707553','F?tima', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1707652','Figueir?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1707702','Filad?lfia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1708205','Formoso do Araguaia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1708254','Fortaleza do Taboc?o', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1708304','Goianorte', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1709005','Goiatins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1709302','Guara?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1709500','Gurupi', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1709807','Ipueiras', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1710508','Itacaj?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1710706','Itaguatins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1710904','Itapiratins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1711100','Itapor? do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1711506','Ja? do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1711803','Juarina', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1711902','Lagoa da Confus?o', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1711951','Lagoa do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1712009','Lajeado', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1712157','Lavandeira', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1712405','Lizarda', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1712454','Luzin?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1712504','Marian?polis do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1712702','Mateiros', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1712801','Mauril?ndia do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1713205','Miracema do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1713304','Miranorte', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1713601','Monte do Carmo', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1713700','Monte Santo do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1713809','Palmeiras do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1713957','Muricil?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1714203','Natividade', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1714302','Nazar?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1714880','Nova Olinda', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1715002','Nova Rosal?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1715101','Novo Acordo', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1715150','Novo Alegre', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1715259','Novo Jardim', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1715507','Oliveira de F?tima', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1715705','Palmeirante', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1715754','Palmeir?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1716109','Para?so do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1716208','Paran?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1716307','Pau D''Arco', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1716505','Pedro Afonso', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1716604','Peixe', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1716653','Pequizeiro', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1716703','Colm?ia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1717008','Pindorama do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1717206','Piraqu?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1717503','Pium', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1717800','Ponte Alta do Bom Jesus', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1717909','Ponte Alta do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718006','Porto Alegre do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718204','Porto Nacional', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718303','Praia Norte', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718402','Presidente Kennedy', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718451','Pugmil', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718501','Recursol?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718550','Riachinho', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718659','Rio da Concei??o', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718709','Rio dos Bois', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718758','Rio Sono', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718808','Sampaio', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718840','Sandol?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718865','Santa F? do Araguaia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718881','Santa Maria do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718899','Santa Rita do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1718907','Santa Rosa do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1719004','Santa Tereza do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720002','Santa Terezinha do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720101','S?o Bento do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720150','S?o F?lix do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720200','S?o Miguel do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720259','S?o Salvador do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720309','S?o Sebasti?o do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720499','S?o Val?rio', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720655','Silvan?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720804','S?tio Novo do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720853','Sucupira', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720903','Taguatinga', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720937','Taipas do Tocantins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1720978','Talism?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1721000','Palmas', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1721109','Tocant?nia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1721208','Tocantin?polis', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1721257','Tupirama', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1721307','Tupiratins', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1722081','Wanderl?ndia', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('1722107','Xambio?', 17);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100055','A?ail?ndia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100105','Afonso Cunha', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100154','?gua Doce do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100204','Alc?ntara', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100303','Aldeias Altas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100402','Altamira do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100436','Alto Alegre do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100477','Alto Alegre do Pindar?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100501','Alto Parna?ba', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100550','Amap? do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100600','Amarante do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100709','Anajatuba', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100808','Anapurus', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100832','Apicum-A?u', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100873','Araguan?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100907','Araioses', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2100956','Arame', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101004','Arari', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101103','Axix?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101202','Bacabal', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101251','Bacabeira', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101301','Bacuri', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101350','Bacurituba', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101400','Balsas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101509','Bar?o de Graja?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101608','Barra do Corda', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101707','Barreirinhas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101731','Bel?gua', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101772','Bela Vista do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101806','Benedito Leite', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101905','Bequim?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101939','Bernardo do Mearim', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2101970','Boa Vista do Gurupi', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102002','Bom Jardim', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102036','Bom Jesus das Selvas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102077','Bom Lugar', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102101','Brejo', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102150','Brejo de Areia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102200','Buriti', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102309','Buriti Bravo', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102325','Buriticupu', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102358','Buritirana', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102374','Cachoeira Grande', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102408','Cajapi?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102507','Cajari', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102556','Campestre do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102606','C?ndido Mendes', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102705','Cantanhede', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102754','Capinzal do Norte', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102804','Carolina', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2102903','Carutapera', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103000','Caxias', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103109','Cedral', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103125','Central do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103158','Centro do Guilherme', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103174','Centro Novo do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103208','Chapadinha', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103257','Cidel?ndia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103307','Cod?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103406','Coelho Neto', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103505','Colinas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103554','Concei??o do Lago-A?u', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103604','Coroat?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103703','Cururupu', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103752','Davin?polis', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103802','Dom Pedro', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2103901','Duque Bacelar', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104008','Esperantin?polis', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104057','Estreito', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104073','Feira Nova do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104081','Fernando Falc?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104099','Formosa da Serra Negra', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104107','Fortaleza dos Nogueiras', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104206','Fortuna', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104305','Godofredo Viana', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104404','Gon?alves Dias', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104503','Governador Archer', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104552','Governador Edison Lob?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104602','Governador Eug?nio Barros', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104628','Governador Luiz Rocha', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104651','Governador Newton Bello', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104677','Governador Nunes Freire', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104701','Gra?a Aranha', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104800','Graja?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2104909','Guimar?es', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105005','Humberto de Campos', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105104','Icatu', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105153','Igarap? do Meio', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105203','Igarap? Grande', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105302','Imperatriz', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105351','Itaipava do Graja?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105401','Itapecuru Mirim', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105427','Itinga do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105450','Jatob?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105476','Jenipapo dos Vieiras', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105500','Jo?o Lisboa', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105609','Josel?ndia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105658','Junco do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105708','Lago da Pedra', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105807','Lago do Junco', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105906','Lago Verde', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105922','Lagoa do Mato', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105948','Lago dos Rodrigues', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105963','Lagoa Grande do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2105989','Lajeado Novo', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106003','Lima Campos', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106102','Loreto', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106201','Lu?s Domingues', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106300','Magalh?es de Almeida', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106326','Maraca?um?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106359','Maraj? do Sena', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106375','Maranh?ozinho', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106409','Mata Roma', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106508','Matinha', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106607','Mat?es', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106631','Mat?es do Norte', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106672','Milagres do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106706','Mirador', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106755','Miranda do Norte', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106805','Mirinzal', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2106904','Mon??o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107001','Montes Altos', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107100','Morros', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107209','Nina Rodrigues', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107258','Nova Colinas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107308','Nova Iorque', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107357','Nova Olinda do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107407','Olho D''?gua das Cunh?s', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107456','Olinda Nova do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107506','Pa?o do Lumiar', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107605','Palmeir?ndia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107704','Paraibano', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107803','Parnarama', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2107902','Passagem Franca', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108009','Pastos Bons', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108058','Paulino Neves', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108108','Paulo Ramos', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108207','Pedreiras', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108256','Pedro do Ros?rio', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108306','Penalva', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108405','Peri Mirim', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108454','Peritor?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108504','Pindar?-Mirim', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108603','Pinheiro', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108702','Pio XII', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108801','Pirapemas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2108900','Po??o de Pedras', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109007','Porto Franco', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109056','Porto Rico do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109106','Presidente Dutra', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109205','Presidente Juscelino', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109239','Presidente M?dici', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109270','Presidente Sarney', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109304','Presidente Vargas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109403','Primeira Cruz', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109452','Raposa', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109502','Riach?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109551','Ribamar Fiquene', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109601','Ros?rio', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109700','Samba?ba', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109759','Santa Filomena do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109809','Santa Helena', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2109908','Santa In?s', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110005','Santa Luzia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110039','Santa Luzia do Paru?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110104','Santa Quit?ria do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110203','Santa Rita', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110237','Santana do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110278','Santo Amaro do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110302','Santo Ant?nio dos Lopes', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110401','S?o Benedito do Rio Preto', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110500','S?o Bento', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110609','S?o Bernardo', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110658','S?o Domingos do Azeit?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110708','S?o Domingos do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110807','S?o F?lix de Balsas', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110856','S?o Francisco do Brej?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2110906','S?o Francisco do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111003','S?o Jo?o Batista', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111029','S?o Jo?o do Car?', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111052','S?o Jo?o do Para?so', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111078','S?o Jo?o do Soter', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111102','S?o Jo?o dos Patos', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111201','S?o Jos? de Ribamar', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111250','S?o Jos? dos Bas?lios', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111300','S?o Lu?s', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111409','S?o Lu?s Gonzaga do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111508','S?o Mateus do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111532','S?o Pedro da ?gua Branca', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111573','S?o Pedro dos Crentes', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111607','S?o Raimundo das Mangabeiras', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111631','S?o Raimundo do Doca Bezerra', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111672','S?o Roberto', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111706','S?o Vicente Ferrer', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111722','Satubinha', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111748','Senador Alexandre Costa', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111763','Senador La Rocque', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111789','Serrano do Maranh?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111805','S?tio Novo', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111904','Sucupira do Norte', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2111953','Sucupira do Riach?o', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112001','Tasso Fragoso', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112100','Timbiras', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112209','Timon', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112233','Trizidela do Vale', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112274','Tcod_estil?ndia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112308','Tuntum', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112407','Turia?u', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112456','Turil?ndia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112506','Tut?ia', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112605','Urbano Santos', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112704','Vargem Grande', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112803','Viana', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112852','Vila Nova dos Mart?rios', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2112902','Vit?ria do Mearim', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2113009','Vitorino Freire', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2114007','Z? Doca', 21);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200053','Acau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200103','Agricol?ndia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200202','?gua Branca', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200251','Alagoinha do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200277','Alegrete do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200301','Alto Long?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200400','Altos', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200459','Alvorada do Gurgu?ia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200509','Amarante', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200608','Angical do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200707','An?sio de Abreu', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200806','Ant?nio Almeida', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200905','Aroazes', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2200954','Aroeiras do Itaim', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201002','Arraial', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201051','Assun??o do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201101','Avelino Lopes', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201150','Baixa Grande do Ribeiro', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201176','Barra D''Alc?ntara', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201200','Barras', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201309','Barreiras do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201408','Barro Duro', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201507','Batalha', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201556','Bela Vista do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201572','Bel?m do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201606','Beneditinos', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201705','Bertol?nia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201739','Bet?nia do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201770','Boa Hora', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201804','Bocaina', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201903','Bom Jesus', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201919','Bom Princ?pio do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201929','Bonfim do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201945','Boqueir?o do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201960','Brasileira', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2201988','Brejo do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202000','Buriti dos Lopes', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202026','Buriti dos Montes', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202059','Cabeceiras do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202075','Cajazeiras do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202083','Cajueiro da Praia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202091','Caldeir?o Grande do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202109','Campinas do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202117','Campo Alegre do Fidalgo', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202133','Campo Grande do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202174','Campo Largo do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202208','Campo Maior', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202251','Canavieira', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202307','Canto do Buriti', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202406','Capit?o de Campos', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202455','Capit?o Gerv?sio Oliveira', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202505','Caracol', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202539','Cara?bas do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202554','Caridade do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202604','Castelo do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202653','Caxing?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202703','Cocal', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202711','Cocal de Telha', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202729','Cocal dos Alves', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202737','Coivaras', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202752','Col?nia do Gurgu?ia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202778','Col?nia do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202802','Concei??o do Canind?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202851','Coronel Jos? Dias', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2202901','Corrente', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203008','Cristal?ndia do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203107','Cristino Castro', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203206','Curimat?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203230','Currais', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203255','Curralinhos', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203271','Curral Novo do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203305','Demerval Lob?o', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203354','Dirceu Arcoverde', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203404','Dom Expedito Lopes', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203420','Domingos Mour?o', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203453','Dom Inoc?ncio', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203503','Elesb?o Veloso', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203602','Eliseu Martins', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203701','Esperantina', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203750','Fartura do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203800','Flores do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203859','Floresta do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2203909','Floriano', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204006','Francin?polis', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204105','Francisco Ayres', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204154','Francisco Macedo', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204204','Francisco Santos', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204303','Fronteiras', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204352','Geminiano', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204402','Gilbu?s', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204501','Guadalupe', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204550','Guaribas', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204600','Hugo Napole?o', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204659','Ilha Grande', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204709','Inhuma', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204808','Ipiranga do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2204907','Isa?as Coelho', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205003','Itain?polis', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205102','Itaueira', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205151','Jacobina do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205201','Jaic?s', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205250','Jardim do Mulato', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205276','Jatob? do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205300','Jerumenha', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205359','Jo?o Costa', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205409','Joaquim Pires', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205458','Joca Marques', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205508','Jos? de Freitas', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205516','Juazeiro do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205524','J?lio Borges', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205532','Jurema', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205540','Lagoinha do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205557','Lagoa Alegre', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205565','Lagoa do Barro do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205573','Lagoa de S?o Francisco', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205581','Lagoa do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205599','Lagoa do S?tio', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205607','Landri Sales', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205706','Lu?s Correia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205805','Luzil?ndia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205854','Madeiro', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205904','Manoel Em?dio', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2205953','Marcol?ndia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206001','Marcos Parente', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206050','Massap? do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206100','Matias Ol?mpio', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206209','Miguel Alves', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206308','Miguel Le?o', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206357','Milton Brand?o', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206407','Monsenhor Gil', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206506','Monsenhor Hip?lito', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206605','Monte Alegre do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206654','Morro Cabe?a no Tempo', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206670','Morro do Chap?u do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206696','Murici dos Portelas', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206704','Nazar? do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206720','Naz?ria', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206753','Nossa Senhora de Nazar?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206803','Nossa Senhora dos Rem?dios', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206902','Novo Oriente do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2206951','Novo Santo Ant?nio', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207009','Oeiras', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207108','Olho D''?gua do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207207','Padre Marcos', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207306','Paes Landim', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207355','Paje? do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207405','Palmeira do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207504','Palmeirais', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207553','Paquet?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207603','Parnagu?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207702','Parna?ba', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207751','Passagem Franca do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207777','Patos do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207793','Pau D''Arco do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207801','Paulistana', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207850','Pavussu', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207900','Pedro II', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207934','Pedro Laurentino', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2207959','Nova Santa Rita', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208007','Picos', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208106','Pimenteiras', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208205','Pio IX', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208304','Piracuruca', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208403','Piripiri', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208502','Porto', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208551','Porto Alegre do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208601','Prata do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208650','Queimada Nova', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208700','Reden??o do Gurgu?ia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208809','Regenera??o', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208858','Riacho Frio', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208874','Ribeira do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2208908','Ribeiro Gon?alves', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209005','Rio Grande do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209104','Santa Cruz do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209153','Santa Cruz dos Milagres', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209203','Santa Filomena', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209302','Santa Luz', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209351','Santana do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209377','Santa Rosa do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209401','Santo Ant?nio de Lisboa', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209450','Santo Ant?nio dos Milagres', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209500','Santo In?cio do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209559','S?o Braz do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209609','S?o F?lix do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209658','S?o Francisco de Assis do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209708','S?o Francisco do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209757','S?o Gon?alo do Gurgu?ia', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209807','S?o Gon?alo do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209856','S?o Jo?o da Canabrava', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209872','S?o Jo?o da Fronteira', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209906','S?o Jo?o da Serra', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209955','S?o Jo?o da Varjota', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2209971','S?o Jo?o do Arraial', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210003','S?o Jo?o do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210052','S?o Jos? do Divino', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210102','S?o Jos? do Peixe', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210201','S?o Jos? do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210300','S?o Juli?o', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210359','S?o Louren?o do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210375','S?o Luis do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210383','S?o Miguel da Baixa Grande', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210391','S?o Miguel do Fidalgo', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210409','S?o Miguel do Tapuio', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210508','S?o Pedro do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210607','S?o Raimundo Nonato', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210623','Sebasti?o Barros', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210631','Sebasti?o Leal', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210656','Sigefredo Pacheco', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210706','Sim?es', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210805','Simpl?cio Mendes', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210904','Socorro do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210938','Sussuapara', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210953','Tamboril do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2210979','Tanque do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211001','Teresina', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211100','Uni?o', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211209','Uru?u?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211308','Valen?a do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211357','V?rzea Branca', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211407','V?rzea Grande', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211506','Vera Mendes', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211605','Vila Nova do Piau?', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2211704','Wall Ferraz', 22);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300101','Abaiara', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300150','Acarape', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300200','Acara?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300309','Acopiara', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300408','Aiuaba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300507','Alc?ntaras', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300606','Altaneira', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300705','Alto Santo', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300754','Amontada', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300804','Antonina do Norte', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2300903','Apuiar?s', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301000','Aquiraz', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301109','Aracati', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301208','Aracoiaba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301257','Ararend?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301307','Araripe', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301406','Aratuba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301505','Arneiroz', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301604','Assar?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301703','Aurora', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301802','Baixio', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301851','Banabui?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301901','Barbalha', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2301950','Barreira', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302008','Barro', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302057','Barroquinha', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302107','Baturit?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302206','Beberibe', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302305','Bela Cruz', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302404','Boa Viagem', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302503','Brejo Santo', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302602','Camocim', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302701','Campos Sales', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302800','Canind?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2302909','Capistrano', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303006','Caridade', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303105','Carir?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303204','Cariria?u', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303303','Cari?s', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303402','Carnaubal', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303501','Cascavel', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303600','Catarina', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303659','Catunda', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303709','Caucaia', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303808','Cedro', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303907','Chaval', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303931','Chor?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2303956','Chorozinho', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304004','Corea?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304103','Crate?s', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304202','Crato', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304236','Croat?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304251','Cruz', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304269','Deputado Irapuan Pinheiro', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304277','Erer?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304285','Eus?bio', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304301','Farias Brito', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304350','Forquilha', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304400','Fortaleza', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304459','Fortim', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304509','Frecheirinha', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304608','General Sampaio', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304657','Gra?a', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304707','Granja', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304806','Granjeiro', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304905','Groa?ras', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2304954','Guai?ba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305001','Guaraciaba do Norte', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305100','Guaramiranga', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305209','Hidrol?ndia', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305233','Horizonte', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305266','Ibaretama', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305308','Ibiapina', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305332','Ibicuitinga', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305357','Icapu?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305407','Ic?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305506','Iguatu', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305605','Independ?ncia', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305654','Ipaporanga', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305704','Ipaumirim', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305803','Ipu', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2305902','Ipueiras', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306009','Iracema', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306108','Irau?uba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306207','Itai?aba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306256','Itaitinga', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306306','Itapag?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306405','Itapipoca', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306504','Itapi?na', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306553','Itarema', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306603','Itatira', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306702','Jaguaretama', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306801','Jaguaribara', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2306900','Jaguaribe', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307007','Jaguaruana', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307106','Jardim', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307205','Jati', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307254','Jijoca de Jericoacoara', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307304','Juazeiro do Norte', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307403','Juc?s', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307502','Lavras da Mangabeira', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307601','Limoeiro do Norte', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307635','Madalena', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307650','Maracana?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307700','Maranguape', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307809','Marco', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2307908','Martin?pole', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308005','Massap?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308104','Mauriti', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308203','Meruoca', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308302','Milagres', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308351','Milh?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308377','Mira?ma', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308401','Miss?o Velha', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308500','Momba?a', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308609','Monsenhor Tabosa', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308708','Morada Nova', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308807','Mora?jo', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2308906','Morrinhos', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309003','Mucambo', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309102','Mulungu', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309201','Nova Olinda', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309300','Nova Russas', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309409','Novo Oriente', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309458','Ocara', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309508','Or?s', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309607','Pacajus', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309706','Pacatuba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309805','Pacoti', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2309904','Pacuj?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310001','Palhano', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310100','Palm?cia', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310209','Paracuru', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310258','Paraipaba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310308','Parambu', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310407','Paramoti', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310506','Pedra Branca', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310605','Penaforte', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310704','Pentecoste', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310803','Pereiro', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310852','Pindoretama', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310902','Piquet Carneiro', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2310951','Pires Ferreira', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311009','Poranga', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311108','Porteiras', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311207','Potengi', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311231','Potiretama', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311264','Quiterian?polis', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311306','Quixad?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311355','Quixel?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311405','Quixeramobim', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311504','Quixer?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311603','Reden??o', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311702','Reriutaba', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311801','Russas', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311900','Saboeiro', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2311959','Salitre', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312007','Santana do Acara?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312106','Santana do Cariri', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312205','Santa Quit?ria', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312304','S?o Benedito', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312403','S?o Gon?alo do Amarante', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312502','S?o Jo?o do Jaguaribe', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312601','S?o Lu?s do Curu', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312700','Senador Pompeu', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312809','Senador S?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2312908','Sobral', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313005','Solon?pole', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313104','Tabuleiro do Norte', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313203','Tamboril', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313252','Tarrafas', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313302','Tau?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313351','Teju?uoca', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313401','Tiangu?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313500','Trairi', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313559','Tururu', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313609','Ubajara', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313708','Umari', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313757','Umirim', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313807','Uruburetama', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313906','Uruoca', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2313955','Varjota', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2314003','V?rzea Alegre', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2314102','Vi?osa do Cear?', 23);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400109','Acari', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400208','A?u', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400307','Afonso Bezerra', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400406','?gua Nova', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400505','Alexandria', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400604','Almino Afonso', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400703','Alto do Rodrigues', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400802','Angicos', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2400901','Ant?nio Martins', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401008','Apodi', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401107','Areia Branca', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401206','Ar?s', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401305','Augusto Severo', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401404','Ba?a Formosa', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401453','Bara?na', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401503','Barcelona', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401602','Bento Fernandes', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401651','Bod?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401701','Bom Jesus', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401800','Brejinho', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401859','Cai?ara do Norte', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2401909','Cai?ara do Rio do Vento', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402006','Caic?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402105','Campo Redondo', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402204','Canguaretama', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402303','Cara?bas', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402402','Carna?ba dos Dantas', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402501','Carnaubais', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402600','Cear?-Mirim', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402709','Cerro Cor?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402808','Coronel Ezequiel', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2402907','Coronel Jo?o Pessoa', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403004','Cruzeta', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403103','Currais Novos', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403202','Doutor Severiano', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403251','Parnamirim', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403301','Encanto', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403400','Equador', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403509','Esp?rito Santo', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403608','Extremoz', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403707','Felipe Guerra', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403756','Fernando Pedroza', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403806','Flor?nia', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2403905','Francisco Dantas', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404002','Frutuoso Gomes', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404101','Galinhos', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404200','Goianinha', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404309','Governador Dix-Sept Rosado', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404408','Grossos', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404507','Guamar?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404606','Ielmo Marinho', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404705','Ipangua?u', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404804','Ipueira', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404853','Itaj?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2404903','Ita?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405009','Ja?an?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405108','Janda?ra', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405207','Jandu?s', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405306','Janu?rio Cicco', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405405','Japi', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405504','Jardim de Angicos', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405603','Jardim de Piranhas', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405702','Jardim do Serid?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405801','Jo?o C?mara', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2405900','Jo?o Dias', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406007','Jos? da Penha', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406106','Jucurutu', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406155','Jundi?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406205','Lagoa D''Anta', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406304','Lagoa de Pedras', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406403','Lagoa de Velhos', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406502','Lagoa Nova', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406601','Lagoa Salgada', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406700','Lajes', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406809','Lajes Pintadas', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2406908','Lucr?cia', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407005','Lu?s Gomes', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407104','Maca?ba', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407203','Macau', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407252','Major Sales', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407302','Marcelino Vieira', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407401','Martins', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407500','Maxaranguape', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407609','Messias Targino', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407708','Montanhas', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407807','Monte Alegre', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2407906','Monte das Gameleiras', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408003','Mossor?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408102','Natal', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408201','N?sia Floresta', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408300','Nova Cruz', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408409','Olho-D''?gua do Borges', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408508','Ouro Branco', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408607','Paran?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408706','Para?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408805','Parazinho', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408904','Parelhas', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2408953','Rio do Fogo', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409100','Passa e Fica', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409209','Passagem', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409308','Patu', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409332','Santa Maria', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409407','Pau dos Ferros', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409506','Pedra Grande', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409605','Pedra Preta', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409704','Pedro Avelino', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409803','Pedro Velho', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2409902','Pend?ncias', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410009','Pil?es', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410108','Po?o Branco', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410207','Portalegre', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410256','Porto do Mangue', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410306','Presidente Juscelino', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410405','Pureza', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410504','Rafael Fernandes', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410603','Rafael Godeiro', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410702','Riacho da Cruz', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410801','Riacho de Santana', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2410900','Riachuelo', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411007','Rodolfo Fernandes', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411056','Tibau', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411106','Ruy Barbosa', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411205','Santa Cruz', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411403','Santana do Matos', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411429','Santana do Serid?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411502','Santo Ant?nio', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411601','S?o Bento do Norte', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411700','S?o Bento do Trair?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411809','S?o Fernando', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2411908','S?o Francisco do Oeste', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412005','S?o Gon?alo do Amarante', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412104','S?o Jo?o do Sabugi', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412203','S?o Jos? de Mipibu', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412302','S?o Jos? do Campestre', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412401','S?o Jos? do Serid?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412500','S?o Miguel', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412559','S?o Miguel do Gostoso', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412609','S?o Paulo do Potengi', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412708','S?o Pedro', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412807','S?o Rafael', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2412906','S?o Tom?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413003','S?o Vicente', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413102','Senador El?i de Souza', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413201','Senador Georgino Avelino', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413300','Serra de S?o Bento', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413359','Serra do Mel', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413409','Serra Negra do Norte', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413508','Serrinha', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413557','Serrinha dos Pintos', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413607','Severiano Melo', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413706','S?tio Novo', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413805','Taboleiro Grande', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2413904','Taipu', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414001','Tangar?', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414100','Tenente Ananias', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414159','Tenente Laurentino Cruz', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414209','Tibau do Sul', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414308','Timba?ba dos Batistas', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414407','Touros', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414456','Triunfo Potiguar', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414506','Umarizal', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414605','Upanema', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414704','V?rzea', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414753','Venha-Ver', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414803','Vera Cruz', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2414902','Vi?osa', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2415008','Vila Flor', 24);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500106','?gua Branca', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500205','Aguiar', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500304','Alagoa Grande', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500403','Alagoa Nova', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500502','Alagoinha', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500536','Alcantil', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500577','Algod?o de Janda?ra', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500601','Alhandra', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500700','S?o Jo?o do Rio do Peixe', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500734','Amparo', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500775','Aparecida', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500809','Ara?agi', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2500908','Arara', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501005','Araruna', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501104','Areia', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501153','Areia de Bara?nas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501203','Areial', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501302','Aroeiras', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501351','Assun??o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501401','Ba?a da Trai??o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501500','Bananeiras', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501534','Bara?na', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501575','Barra de Santana', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501609','Barra de Santa Rosa', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501708','Barra de S?o Miguel', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501807','Bayeux', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2501906','Bel?m', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502003','Bel?m do Brejo do Cruz', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502052','Bernardino Batista', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502102','Boa Ventura', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502151','Boa Vista', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502201','Bom Jesus', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502300','Bom Sucesso', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502409','Bonito de Santa F?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502508','Boqueir?o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502607','Igaracy', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502706','Borborema', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502805','Brejo do Cruz', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2502904','Brejo dos Santos', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503001','Caapor?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503100','Cabaceiras', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503209','Cabedelo', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503308','Cachoeira dos ?ndios', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503407','Cacimba de Areia', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503506','Cacimba de Dentro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503555','Cacimbas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503605','Cai?ara', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503704','Cajazeiras', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503753','Cajazeirinhas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503803','Caldas Brand?o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2503902','Camala?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504009','Campina Grande', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504033','Capim', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504074','Cara?bas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504108','Carrapateira', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504157','Casserengue', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504207','Catingueira', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504306','Catol? do Rocha', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504355','Caturit?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504405','Concei??o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504504','Condado', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504603','Conde', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504702','Congo', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504801','Coremas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504850','Coxixola', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2504900','Cruz do Esp?rito Santo', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505006','Cubati', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505105','Cuit?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505204','Cuitegi', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505238','Cuit? de Mamanguape', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505279','Curral de Cima', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505303','Curral Velho', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505352','Dami?o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505402','Desterro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505501','Vista Serrana', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505600','Diamante', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505709','Dona In?s', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505808','Duas Estradas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2505907','Emas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506004','Esperan?a', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506103','Fagundes', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506202','Frei Martinho', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506251','Gado Bravo', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506301','Guarabira', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506400','Gurinh?m', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506509','Gurj?o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506608','Ibiara', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506707','Imaculada', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506806','Ing?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2506905','Itabaiana', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507002','Itaporanga', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507101','Itapororoca', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507200','Itatuba', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507309','Jacara?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507408','Jeric?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507507','Jo?o Pessoa', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507606','Juarez T?vora', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507705','Juazeirinho', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507804','Junco do Serid?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2507903','Juripiranga', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508000','Juru', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508109','Lagoa', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508208','Lagoa de Dentro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508307','Lagoa Seca', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508406','Lastro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508505','Livramento', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508554','Logradouro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508604','Lucena', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508703','M?e D''?gua', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508802','Malta', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2508901','Mamanguape', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509008','Mana?ra', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509057','Marca??o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509107','Mari', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509156','Mariz?polis', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509206','Massaranduba', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509305','Mataraca', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509339','Matinhas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509370','Mato Grosso', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509396','Matur?ia', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509404','Mogeiro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509503','Montadas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509602','Monte Horebe', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509701','Monteiro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509800','Mulungu', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2509909','Natuba', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510006','Nazarezinho', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510105','Nova Floresta', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510204','Nova Olinda', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510303','Nova Palmeira', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510402','Olho D''?gua', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510501','Olivedos', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510600','Ouro Velho', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510659','Parari', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510709','Passagem', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510808','Patos', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2510907','Paulista', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511004','Pedra Branca', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511103','Pedra Lavrada', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511202','Pedras de Fogo', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511301','Pianc?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511400','Picu?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511509','Pilar', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511608','Pil?es', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511707','Pil?ezinhos', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511806','Pirpirituba', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2511905','Pitimbu', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512002','Pocinhos', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512036','Po?o Dantas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512077','Po?o de Jos? de Moura', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512101','Pombal', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512200','Prata', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512309','Princesa Isabel', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512408','Puxinan?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512507','Queimadas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512606','Quixab?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512705','Rem?gio', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512721','Pedro R?gis', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512747','Riach?o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512754','Riach?o do Bacamarte', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512762','Riach?o do Po?o', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512788','Riacho de Santo Ant?nio', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512804','Riacho dos Cavalos', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2512903','Rio Tinto', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513000','Salgadinho', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513109','Salgado de S?o F?lix', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513158','Santa Cec?lia', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513208','Santa Cruz', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513307','Santa Helena', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513356','Santa In?s', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513406','Santa Luzia', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513505','Santana de Mangueira', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513604','Santana dos Garrotes', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513653','Joca Claudino', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513703','Santa Rita', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513802','Santa Teresinha', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513851','Santo Andr?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513901','S?o Bento', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513927','S?o Bentinho', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513943','S?o Domingos do Cariri', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513968','S?o Domingos', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2513984','S?o Francisco', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514008','S?o Jo?o do Cariri', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514107','S?o Jo?o do Tigre', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514206','S?o Jos? da Lagoa Tapada', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514305','S?o Jos? de Caiana', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514404','S?o Jos? de Espinharas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514453','S?o Jos? dos Ramos', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514503','S?o Jos? de Piranhas', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514552','S?o Jos? de Princesa', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514602','S?o Jos? do Bonfim', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514651','S?o Jos? do Brejo do Cruz', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514701','S?o Jos? do Sabugi', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514800','S?o Jos? dos Cordeiros', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2514909','S?o Mamede', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515005','S?o Miguel de Taipu', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515104','S?o Sebasti?o de Lagoa de Ro?a', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515203','S?o Sebasti?o do Umbuzeiro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515302','Sap?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515401','S?o Vicente do Serid?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515500','Serra Branca', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515609','Serra da Raiz', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515708','Serra Grande', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515807','Serra Redonda', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515906','Serraria', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515930','Sert?ozinho', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2515971','Sobrado', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516003','Sol?nea', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516102','Soledade', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516151','Soss?go', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516201','Sousa', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516300','Sum?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516409','Tacima', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516508','Tapero?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516607','Tavares', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516706','Teixeira', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516755','Ten?rio', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516805','Triunfo', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2516904','Uira?na', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2517001','Umbuzeiro', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2517100','V?rzea', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2517209','Vieir?polis', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2517407','Zabel?', 25);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600054','Abreu e Lima', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600104','Afogados da Ingazeira', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600203','Afr?nio', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600302','Agrestina', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600401','?gua Preta', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600500','?guas Belas', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600609','Alagoinha', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600708','Alian?a', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600807','Altinho', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2600906','Amaraji', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601003','Angelim', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601052','Ara?oiaba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601102','Araripina', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601201','Arcoverde', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601300','Barra de Guabiraba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601409','Barreiros', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601508','Bel?m de Maria', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601607','Bel?m do S?o Francisco', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601706','Belo Jardim', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601805','Bet?nia', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2601904','Bezerros', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602001','Bodoc?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602100','Bom Conselho', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602209','Bom Jardim', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602308','Bonito', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602407','Brej?o', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602506','Brejinho', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602605','Brejo da Madre de Deus', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602704','Buenos Aires', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602803','Bu?que', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2602902','Cabo de Santo Agostinho', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603009','Cabrob?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603108','Cachoeirinha', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603207','Caet?s', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603306','Cal?ado', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603405','Calumbi', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603454','Camaragibe', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603504','Camocim de S?o F?lix', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603603','Camutanga', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603702','Canhotinho', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603801','Capoeiras', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603900','Carna?ba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2603926','Carnaubeira da Penha', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604007','Carpina', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604106','Caruaru', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604155','Casinhas', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604205','Catende', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604304','Cedro', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604403','Ch? de Alegria', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604502','Ch? Grande', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604601','Condado', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604700','Correntes', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604809','Cort?s', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2604908','Cumaru', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605004','Cupira', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605103','Cust?dia', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605152','Dormentes', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605202','Escada', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605301','Exu', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605400','Feira Nova', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605459','Fernando de Noronha', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605509','Ferreiros', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605608','Flores', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605707','Floresta', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605806','Frei Miguelinho', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2605905','Gameleira', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606002','Garanhuns', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606101','Gl?ria do Goit?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606200','Goiana', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606309','Granito', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606408','Gravat?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606507','Iati', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606606','Ibimirim', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606705','Ibirajuba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606804','Igarassu', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2606903','Iguaraci', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607000','Inaj?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607109','Ingazeira', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607208','Ipojuca', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607307','Ipubi', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607406','Itacuruba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607505','Ita?ba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607604','Ilha de Itamarac?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607653','Itamb?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607703','Itapetim', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607752','Itapissuma', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607802','Itaquitinga', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607901','Jaboat?o dos Guararapes', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2607950','Jaqueira', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608008','Jata?ba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608057','Jatob?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608107','Jo?o Alfredo', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608206','Joaquim Nabuco', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608255','Jucati', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608305','Jupi', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608404','Jurema', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608453','Lagoa do Carro', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608503','Lagoa de Itaenga', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608602','Lagoa do Ouro', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608701','Lagoa dos Gatos', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608750','Lagoa Grande', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608800','Lajedo', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2608909','Limoeiro', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609006','Macaparana', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609105','Machados', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609154','Manari', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609204','Maraial', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609303','Mirandiba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609402','Moreno', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609501','Nazar? da Mata', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609600','Olinda', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609709','Orob?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609808','Oroc?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2609907','Ouricuri', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610004','Palmares', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610103','Palmeirina', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610202','Panelas', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610301','Paranatama', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610400','Parnamirim', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610509','Passira', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610608','Paudalho', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610707','Paulista', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610806','Pedra', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2610905','Pesqueira', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611002','Petrol?ndia', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611101','Petrolina', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611200','Po??o', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611309','Pombos', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611408','Primavera', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611507','Quipap?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611533','Quixaba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611606','Recife', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611705','Riacho das Almas', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611804','Ribeir?o', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2611903','Rio Formoso', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612000','Sair?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612109','Salgadinho', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612208','Salgueiro', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612307','Salo?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612406','Sanhar?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612455','Santa Cruz', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612471','Santa Cruz da Baixa Verde', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612505','Santa Cruz do Capibaribe', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612554','Santa Filomena', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612604','Santa Maria da Boa Vista', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612703','Santa Maria do Cambuc?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612802','Santa Terezinha', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2612901','S?o Benedito do Sul', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613008','S?o Bento do Una', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613107','S?o Caitano', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613206','S?o Jo?o', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613305','S?o Joaquim do Monte', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613404','S?o Jos? da Coroa Grande', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613503','S?o Jos? do Belmonte', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613602','S?o Jos? do Egito', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613701','S?o Louren?o da Mata', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613800','S?o Vicente Ferrer', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2613909','Serra Talhada', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614006','Serrita', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614105','Sert?nia', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614204','Sirinha?m', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614303','Moreil?ndia', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614402','Solid?o', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614501','Surubim', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614600','Tabira', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614709','Tacaimb?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614808','Tacaratu', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2614857','Tamandar?', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615003','Taquaritinga do Norte', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615102','Terezinha', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615201','Terra Nova', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615300','Timba?ba', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615409','Toritama', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615508','Tracunha?m', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615607','Trindade', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615706','Triunfo', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615805','Tupanatinga', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2615904','Tuparetama', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2616001','Venturosa', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2616100','Verdejante', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2616183','Vertente do L?rio', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2616209','Vertentes', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2616308','Vic?ncia', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2616407','Vit?ria de Santo Ant?o', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2616506','Xex?u', 26);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700102','?gua Branca', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700201','Anadia', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700300','Arapiraca', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700409','Atalaia', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700508','Barra de Santo Ant?nio', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700607','Barra de S?o Miguel', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700706','Batalha', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700805','Bel?m', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2700904','Belo Monte', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701001','Boca da Mata', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701100','Branquinha', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701209','Cacimbinhas', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701308','Cajueiro', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701357','Campestre', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701407','Campo Alegre', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701506','Campo Grande', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701605','Canapi', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701704','Capela', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701803','Carneiros', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2701902','Ch? Preta', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702009','Coit? do N?ia', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702108','Col?nia Leopoldina', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702207','Coqueiro Seco', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702306','Coruripe', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702355','Cra?bas', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702405','Delmiro Gouveia', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702504','Dois Riachos', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702553','Estrela de Alagoas', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702603','Feira Grande', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702702','Feliz Deserto', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702801','Flexeiras', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2702900','Girau do Ponciano', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703007','Ibateguara', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703106','Igaci', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703205','Igreja Nova', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703304','Inhapi', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703403','Jacar? dos Homens', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703502','Jacu?pe', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703601','Japaratinga', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703700','Jaramataia', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703759','Jequi? da Praia', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703809','Joaquim Gomes', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2703908','Jundi?', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704005','Junqueiro', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704104','Lagoa da Canoa', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704203','Limoeiro de Anadia', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704302','Macei?', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704401','Major Isidoro', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704500','Maragogi', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704609','Maravilha', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704708','Marechal Deodoro', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704807','Maribondo', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2704906','Mar Vermelho', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705002','Mata Grande', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705101','Matriz de Camaragibe', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705200','Messias', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705309','Minador do Negr?o', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705408','Monteir?polis', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705507','Murici', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705606','Novo Lino', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705705','Olho D''?gua das Flores', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705804','Olho D''?gua do Casado', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2705903','Olho D''?gua Grande', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706000','Oliven?a', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706109','Ouro Branco', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706208','Palestina', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706307','Palmeira dos ?ndios', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706406','P?o de A??car', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706422','Pariconha', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706448','Paripueira', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706505','Passo de Camaragibe', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706604','Paulo Jacinto', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706703','Penedo', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706802','Pia?abu?u', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2706901','Pilar', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707008','Pindoba', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707107','Piranhas', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707206','Po?o das Trincheiras', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707305','Porto Calvo', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707404','Porto de Pedras', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707503','Porto Real do Col?gio', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707602','Quebrangulo', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707701','Rio Largo', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707800','Roteiro', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2707909','Santa Luzia do Norte', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708006','Santana do Ipanema', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708105','Santana do Munda?', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708204','S?o Br?s', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708303','S?o Jos? da Laje', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708402','S?o Jos? da Tapera', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708501','S?o Lu?s do Quitunde', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708600','S?o Miguel dos Campos', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708709','S?o Miguel dos Milagres', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708808','S?o Sebasti?o', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708907','Satuba', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2708956','Senador Rui Palmeira', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2709004','Tanque D''Arca', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2709103','Taquarana', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2709152','Teot?nio Vilela', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2709202','Traipu', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2709301','Uni?o dos Palmares', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2709400','Vi?osa', 27);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2800100','Amparo de S?o Francisco', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2800209','Aquidab?', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2800308','Aracaju', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2800407','Arau?', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2800506','Areia Branca', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2800605','Barra dos Coqueiros', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2800670','Boquim', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2800704','Brejo Grande', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801009','Campo do Brito', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801108','Canhoba', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801207','Canind? de S?o Francisco', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801306','Capela', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801405','Carira', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801504','Carm?polis', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801603','Cedro de S?o Jo?o', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801702','Cristin?polis', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2801900','Cumbe', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802007','Divina Pastora', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802106','Est?ncia', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802205','Feira Nova', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802304','Frei Paulo', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802403','Gararu', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802502','General Maynard', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802601','Gracho Cardoso', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802700','Ilha das Flores', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802809','Indiaroba', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2802908','Itabaiana', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803005','Itabaianinha', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803104','Itabi', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803203','Itaporanga D''Ajuda', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803302','Japaratuba', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803401','Japoat?', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803500','Lagarto', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803609','Laranjeiras', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803708','Macambira', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803807','Malhada dos Bois', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2803906','Malhador', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804003','Maruim', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804102','Moita Bonita', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804201','Monte Alegre de Sergipe', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804300','Muribeca', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804409','Ne?polis', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804458','Nossa Senhora Aparecida', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804508','Nossa Senhora da Gl?ria', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804607','Nossa Senhora das Dores', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804706','Nossa Senhora de Lourdes', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804805','Nossa Senhora do Socorro', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2804904','Pacatuba', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805000','Pedra Mole', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805109','Pedrinhas', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805208','Pinh?o', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805307','Pirambu', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805406','Po?o Redondo', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805505','Po?o Verde', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805604','Porto da Folha', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805703','Propri?', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805802','Riach?o do Dantas', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2805901','Riachuelo', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806008','Ribeir?polis', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806107','Ros?rio do Catete', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806206','Salgado', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806305','Santa Luzia do Itanhy', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806404','Santana do S?o Francisco', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806503','Santa Rosa de Lima', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806602','Santo Amaro das Brotas', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806701','S?o Crist?v?o', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806800','S?o Domingos', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2806909','S?o Francisco', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2807006','S?o Miguel do Aleixo', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2807105','Sim?o Dias', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2807204','Siriri', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2807303','Telha', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2807402','Tobias Barreto', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2807501','Tomar do Geru', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2807600','Umba?ba', 28);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900108','Aba?ra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900207','Abar?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900306','Acajutiba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900355','Adustina', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900405','?gua Fria', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900504','?rico Cardoso', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900603','Aiquara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900702','Alagoinhas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900801','Alcoba?a', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2900900','Almadina', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901007','Amargosa', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901106','Am?lia Rodrigues', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901155','Am?rica Dourada', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901205','Anag?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901304','Andara?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901353','Andorinha', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901403','Angical', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901502','Anguera', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901601','Antas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901700','Ant?nio Cardoso', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901809','Ant?nio Gon?alves', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901908','Apor?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2901957','Apuarema', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902005','Aracatu', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902054','Ara?as', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902104','Araci', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902203','Aramari', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902252','Arataca', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902302','Aratu?pe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902401','Aurelino Leal', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902500','Baian?polis', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902609','Baixa Grande', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902658','Banza?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902708','Barra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902807','Barra da Estiva', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2902906','Barra do Cho?a', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903003','Barra do Mendes', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903102','Barra do Rocha', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903201','Barreiras', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903235','Barro Alto', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903276','Barrocas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903300','Barro Preto', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903409','Belmonte', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903508','Belo Campo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903607','Biritinga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903706','Boa Nova', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903805','Boa Vista do Tupim', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903904','Bom Jesus da Lapa', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2903953','Bom Jesus da Serra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904001','Boninal', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904050','Bonito', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904100','Boquira', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904209','Botupor?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904308','Brej?es', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904407','Brejol?ndia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904506','Brotas de Maca?bas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904605','Brumado', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904704','Buerarema', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904753','Buritirama', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904803','Caatiba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904852','Cabaceiras do Paragua?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2904902','Cachoeira', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905008','Cacul?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905107','Ca?m', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905156','Caetanos', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905206','Caetit?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905305','Cafarnaum', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905404','Cairu', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905503','Caldeir?o Grande', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905602','Camacan', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905701','Cama?ari', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905800','Camamu', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2905909','Campo Alegre de Lourdes', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906006','Campo Formoso', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906105','Can?polis', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906204','Canarana', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906303','Canavieiras', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906402','Candeal', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906501','Candeias', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906600','Candiba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906709','C?ndido Sales', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906808','Cansan??o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906824','Canudos', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906857','Capela do Alto Alegre', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906873','Capim Grosso', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906899','Cara?bas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2906907','Caravelas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907004','Cardeal da Silva', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907103','Carinhanha', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907202','Casa Nova', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907301','Castro Alves', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907400','Catol?ndia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907509','Catu', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907558','Caturama', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907608','Central', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907707','Chorroch?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907806','C?cero Dantas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2907905','Cip?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908002','Coaraci', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908101','Cocos', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908200','Concei??o da Feira', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908309','Concei??o do Almeida', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908408','Concei??o do Coit?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908507','Concei??o do Jacu?pe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908606','Conde', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908705','Conde?ba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908804','Contendas do Sincor?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2908903','Cora??o de Maria', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909000','Cordeiros', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909109','Coribe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909208','Coronel Jo?o S?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909307','Correntina', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909406','Cotegipe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909505','Cravol?ndia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909604','Cris?polis', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909703','Crist?polis', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909802','Cruz das Almas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2909901','Cura??', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910008','D?rio Meira', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910057','Dias D''?vila', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910107','Dom Bas?lio', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910206','Dom Macedo Costa', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910305','El?sio Medrado', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910404','Encruzilhada', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910503','Entre Rios', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910602','Esplanada', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910701','Euclides da Cunha', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910727','Eun?polis', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910750','F?tima', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910776','Feira da Mata', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910800','Feira de Santana', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910859','Filad?lfia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2910909','Firmino Alves', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911006','Floresta Azul', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911105','Formosa do Rio Preto', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911204','Gandu', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911253','Gavi?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911303','Gentio do Ouro', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911402','Gl?ria', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911501','Gongogi', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911600','Governador Mangabeira', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911659','Guajeru', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911709','Guanambi', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911808','Guaratinga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911857','Heli?polis', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2911907','Ia?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912004','Ibiassuc?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912103','Ibicara?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912202','Ibicoara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912301','Ibicu?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912400','Ibipeba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912509','Ibipitanga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912608','Ibiquera', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912707','Ibirapitanga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912806','Ibirapu?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2912905','Ibirataia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913002','Ibitiara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913101','Ibitit?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913200','Ibotirama', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913309','Ichu', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913408','Igapor?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913457','Igrapi?na', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913507','Igua?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913606','Ilh?us', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913705','Inhambupe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913804','Ipecaet?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2913903','Ipia?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914000','Ipir?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914109','Ipupiara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914208','Irajuba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914307','Iramaia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914406','Iraquara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914505','Irar?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914604','Irec?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914653','Itabela', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914703','Itaberaba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914802','Itabuna', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2914901','Itacar?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915007','Itaet?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915106','Itagi', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915205','Itagib?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915304','Itagimirim', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915353','Itagua?u da Bahia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915403','Itaju do Col?nia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915502','Itaju?pe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915601','Itamaraju', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915700','Itamari', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915809','Itamb?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2915908','Itanagra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916005','Itanh?m', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916104','Itaparica', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916203','Itap?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916302','Itapebi', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916401','Itapetinga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916500','Itapicuru', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916609','Itapitanga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916708','Itaquara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916807','Itarantim', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916856','Itatim', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2916906','Itiru?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917003','Iti?ba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917102','Itoror?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917201','Itua?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917300','Ituber?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917334','Iui?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917359','Jaborandi', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917409','Jacaraci', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917508','Jacobina', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917607','Jaguaquara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917706','Jaguarari', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917805','Jaguaripe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2917904','Janda?ra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918001','Jequi?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918100','Jeremoabo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918209','Jiquiri??', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918308','Jita?na', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918357','Jo?o Dourado', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918407','Juazeiro', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918456','Jucuru?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918506','Jussara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918555','Jussari', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918605','Jussiape', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918704','Lafaiete Coutinho', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918753','Lagoa Real', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918803','Laje', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2918902','Lajed?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919009','Lajedinho', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919058','Lajedo do Tabocal', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919108','Lamar?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919157','Lap?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919207','Lauro de Freitas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919306','Len??is', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919405','Lic?nio de Almeida', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919504','Livramento de Nossa Senhora', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919553','Lu?s Eduardo Magalh?es', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919603','Macajuba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919702','Macarani', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919801','Maca?bas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919900','Macurur?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919926','Madre de Deus', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2919959','Maetinga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920007','Maiquinique', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920106','Mairi', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920205','Malhada', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920304','Malhada de Pedras', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920403','Manoel Vitorino', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920452','Mansid?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920502','Marac?s', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920601','Maragogipe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920700','Mara?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920809','Marcion?lio Souza', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2920908','Mascote', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921005','Mata de S?o Jo?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921054','Matina', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921104','Medeiros Neto', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921203','Miguel Calmon', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921302','Milagres', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921401','Mirangaba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921450','Mirante', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921500','Monte Santo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921609','Morpar?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921708','Morro do Chap?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921807','Mortugaba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2921906','Mucug?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922003','Mucuri', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922052','Mulungu do Morro', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922102','Mundo Novo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922201','Muniz Ferreira', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922250','Muqu?m de S?o Francisco', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922300','Muritiba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922409','Mutu?pe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922508','Nazar?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922607','Nilo Pe?anha', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922656','Nordestina', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922706','Nova Cana?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922730','Nova F?tima', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922755','Nova Ibi?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922805','Nova Itarana', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922854','Nova Reden??o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2922904','Nova Soure', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923001','Nova Vi?osa', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923035','Novo Horizonte', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923050','Novo Triunfo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923100','Olindina', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923209','Oliveira dos Brejinhos', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923308','Ouri?angas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923357','Ourol?ndia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923407','Palmas de Monte Alto', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923506','Palmeiras', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923605','Paramirim', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923704','Paratinga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923803','Paripiranga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2923902','Pau Brasil', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924009','Paulo Afonso', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924058','P? de Serra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924108','Pedr?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924207','Pedro Alexandre', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924306','Piat?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924405','Pil?o Arcado', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924504','Pinda?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924603','Pindoba?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924652','Pintadas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924678','Pira? do Norte', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924702','Pirip?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924801','Piritiba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2924900','Planaltino', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925006','Planalto', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925105','Po??es', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925204','Pojuca', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925253','Ponto Novo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925303','Porto Seguro', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925402','Potiragu?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925501','Prado', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925600','Presidente Dutra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925709','Presidente J?nio Quadros', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925758','Presidente Tancredo Neves', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925808','Queimadas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925907','Quijingue', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925931','Quixabeira', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2925956','Rafael Jambeiro', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926004','Remanso', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926103','Retirol?ndia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926202','Riach?o das Neves', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926301','Riach?o do Jacu?pe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926400','Riacho de Santana', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926509','Ribeira do Amparo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926608','Ribeira do Pombal', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926657','Ribeir?o do Largo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926707','Rio de Contas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926806','Rio do Ant?nio', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2926905','Rio do Pires', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927002','Rio Real', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927101','Rodelas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927200','Ruy Barbosa', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927309','Salinas da Margarida', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927408','Salvador', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927507','Santa B?rbara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927606','Santa Br?gida', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927705','Santa Cruz Cabr?lia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927804','Santa Cruz da Vit?ria', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2927903','Santa In?s', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928000','Santaluz', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928059','Santa Luzia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928109','Santa Maria da Vit?ria', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928208','Santana', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928307','Santan?polis', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928406','Santa Rita de C?ssia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928505','Santa Teresinha', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928604','Santo Amaro', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928703','Santo Ant?nio de Jesus', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928802','Santo Est?v?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928901','S?o Desid?rio', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2928950','S?o Domingos', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929008','S?o F?lix', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929057','S?o F?lix do Coribe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929107','S?o Felipe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929206','S?o Francisco do Conde', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929255','S?o Gabriel', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929305','S?o Gon?alo dos Campos', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929354','S?o Jos? da Vit?ria', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929370','S?o Jos? do Jacu?pe', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929404','S?o Miguel das Matas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929503','S?o Sebasti?o do Pass?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929602','Sapea?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929701','S?tiro Dias', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929750','Saubara', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929800','Sa?de', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2929909','Seabra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930006','Sebasti?o Laranjeiras', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930105','Senhor do Bonfim', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930154','Serra do Ramalho', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930204','Sento S?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930303','Serra Dourada', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930402','Serra Preta', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930501','Serrinha', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930600','Serrol?ndia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930709','Sim?es Filho', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930758','S?tio do Mato', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930766','S?tio do Quinto', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930774','Sobradinho', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930808','Souto Soares', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2930907','Tabocas do Brejo Velho', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931004','Tanha?u', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931053','Tanque Novo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931103','Tanquinho', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931202','Tapero?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931301','Tapiramut?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931350','Teixeira de Freitas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931400','Teodoro Sampaio', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931509','Teofil?ndia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931608','Teol?ndia', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931707','Terra Nova', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931806','Tremedal', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2931905','Tucano', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932002','Uau?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932101','Uba?ra', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932200','Ubaitaba', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932309','Ubat?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932408','Uiba?', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932457','Umburanas', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932507','Una', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932606','Urandi', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932705','Uru?uca', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932804','Utinga', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2932903','Valen?a', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933000','Valente', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933059','V?rzea da Ro?a', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933109','V?rzea do Po?o', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933158','V?rzea Nova', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933174','Varzedo', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933208','Vera Cruz', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933257','Vereda', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933307','Vit?ria da Conquista', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933406','Wagner', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933455','Wanderley', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933505','Wenceslau Guimar?es', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('2933604','Xique-Xique', 29);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100104','Abadia dos Dourados', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100203','Abaet?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100302','Abre Campo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100401','Acaiaca', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100500','A?ucena', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100609','?gua Boa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100708','?gua Comprida', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100807','Aguanil', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3100906','?guas Formosas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101003','?guas Vermelhas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101102','Aimor?s', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101201','Aiuruoca', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101300','Alagoa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101409','Albertina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101508','Al?m Para?ba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101607','Alfenas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101631','Alfredo Vasconcelos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101706','Almenara', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101805','Alpercata', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3101904','Alpin?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102001','Alterosa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102050','Alto Capara?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102100','Alto Rio Doce', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102209','Alvarenga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102308','Alvin?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102407','Alvorada de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102506','Amparo do Serra', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102605','Andradas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102704','Cachoeira de Paje?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102803','Andrel?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102852','Angel?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3102902','Ant?nio Carlos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103009','Ant?nio Dias', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103108','Ant?nio Prado de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103207','Ara?a?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103306','Aracitaba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103405','Ara?ua?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103504','Araguari', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103603','Arantina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103702','Araponga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103751','Arapor?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103801','Arapu?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3103900','Ara?jos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104007','Arax?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104106','Arceburgo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104205','Arcos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104304','Areado', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104403','Argirita', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104452','Aricanduva', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104502','Arinos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104601','Astolfo Dutra', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104700','Atal?ia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104809','Augusto de Lima', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3104908','Baependi', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105004','Baldim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105103','Bambu?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105202','Bandeira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105301','Bandeira do Sul', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105400','Bar?o de Cocais', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105509','Bar?o de Monte Alto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105608','Barbacena', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105707','Barra Longa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3105905','Barroso', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106002','Bela Vista de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106101','Belmiro Braga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106200','Belo Horizonte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106309','Belo Oriente', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106408','Belo Vale', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106507','Berilo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106606','Bert?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106655','Berizal', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106705','Betim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106804','Bias Fortes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3106903','Bicas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107000','Biquinhas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107109','Boa Esperan?a', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107208','Bocaina de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107307','Bocai?va', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107406','Bom Despacho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107505','Bom Jardim de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107604','Bom Jesus da Penha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107703','Bom Jesus do Amparo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107802','Bom Jesus do Galho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3107901','Bom Repouso', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108008','Bom Sucesso', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108107','Bonfim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108206','Bonfin?polis de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108255','Bonito de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108305','Borda da Mata', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108404','Botelhos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108503','Botumirim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108552','Brasil?ndia de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108602','Bras?lia de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108701','Br?s Pires', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108800','Bra?nas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3108909','Braz?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109006','Brumadinho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109105','Bueno Brand?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109204','Buen?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109253','Bugre', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109303','Buritis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109402','Buritizeiro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109451','Cabeceira Grande', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109501','Cabo Verde', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109600','Cachoeira da Prata', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109709','Cachoeira de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109808','Cachoeira Dourada', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3109907','Caetan?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110004','Caet?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110103','Caiana', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110202','Cajuri', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110301','Caldas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110400','Camacho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110509','Camanducaia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110608','Cambu?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110707','Cambuquira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110806','Campan?rio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3110905','Campanha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111002','Campestre', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111101','Campina Verde', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111150','Campo Azul', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111200','Campo Belo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111309','Campo do Meio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111408','Campo Florido', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111507','Campos Altos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111606','Campos Gerais', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111705','Cana?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111804','Can?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3111903','Cana Verde', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112000','Candeias', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112059','Cantagalo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112109','Capara?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112208','Capela Nova', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112307','Capelinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112406','Capetinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112505','Capim Branco', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112604','Capin?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112653','Capit?o Andrade', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112703','Capit?o En?as', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112802','Capit?lio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3112901','Caputira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113008','Cara?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113107','Carana?ba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113206','Caranda?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113305','Carangola', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113404','Caratinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113503','Carbonita', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113602','Carea?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113701','Carlos Chagas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113800','Carm?sia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3113909','Carmo da Cachoeira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114006','Carmo da Mata', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114105','Carmo de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114204','Carmo do Cajuru', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114303','Carmo do Parana?ba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114402','Carmo do Rio Claro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114501','Carm?polis de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114550','Carneirinho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114600','Carrancas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114709','Carvalh?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114808','Carvalhos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3114907','Casa Grande', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115003','Cascalho Rico', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115102','C?ssia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115201','Concei??o da Barra de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115300','Cataguases', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115359','Catas Altas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115409','Catas Altas da Noruega', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115458','Catuji', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115474','Catuti', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115508','Caxambu', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115607','Cedro do Abaet?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115706','Central de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115805','Centralina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3115904','Ch?cara', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116001','Chal?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116100','Chapada do Norte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116159','Chapada Ga?cha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116209','Chiador', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116308','Cipot?nea', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116407','Claraval', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116506','Claro dos Po??es', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116605','Cl?udio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116704','Coimbra', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116803','Coluna', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3116902','Comendador Gomes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117009','Comercinho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117108','Concei??o da Aparecida', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117207','Concei??o das Pedras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117306','Concei??o das Alagoas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117405','Concei??o de Ipanema', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117504','Concei??o do Mato Dentro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117603','Concei??o do Par?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117702','Concei??o do Rio Verde', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117801','Concei??o dos Ouros', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117836','C?nego Marinho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117876','Confins', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3117900','Congonhal', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118007','Congonhas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118106','Congonhas do Norte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118205','Conquista', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118304','Conselheiro Lafaiete', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118403','Conselheiro Pena', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118502','Consola??o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118601','Contagem', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118700','Coqueiral', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118809','Cora??o de Jesus', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3118908','Cordisburgo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119005','Cordisl?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119104','Corinto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119203','Coroaci', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119302','Coromandel', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119401','Coronel Fabriciano', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119500','Coronel Murta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119609','Coronel Pacheco', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119708','Coronel Xavier Chaves', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119807','C?rrego Danta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119906','C?rrego do Bom Jesus', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3119955','C?rrego Fundo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120003','C?rrego Novo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120102','Couto de Magalh?es de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120151','Cris?lita', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120201','Cristais', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120300','Crist?lia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120409','Cristiano Otoni', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120508','Cristina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120607','Crucil?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120706','Cruzeiro da Fortaleza', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120805','Cruz?lia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120839','Cuparaque', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120870','Curral de Dentro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3120904','Curvelo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121001','Datas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121100','Delfim Moreira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121209','Delfin?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121258','Delta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121308','Descoberto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121407','Desterro de Entre Rios', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121506','Desterro do Melo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121605','Diamantina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121704','Diogo de Vasconcelos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121803','Dion?sio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3121902','Divin?sia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122009','Divino', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122108','Divino das Laranjeiras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122207','Divinol?ndia de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122306','Divin?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122355','Divisa Alegre', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122405','Divisa Nova', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122454','Divis?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122470','Dom Bosco', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122504','Dom Cavati', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122603','Dom Joaquim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122702','Dom Silv?rio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122801','Dom Vi?oso', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3122900','Dona Eus?bia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123007','Dores de Campos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123106','Dores de Guanh?es', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123205','Dores do Indai?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123304','Dores do Turvo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123403','Dores?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123502','Douradoquara', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123528','Durand?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123601','El?i Mendes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123700','Engenheiro Caldas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123809','Engenheiro Navarro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123858','Entre Folhas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3123908','Entre Rios de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124005','Erv?lia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124104','Esmeraldas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124203','Espera Feliz', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124302','Espinosa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124401','Esp?rito Santo do Dourado', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124500','Estiva', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124609','Estrela Dalva', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124708','Estrela do Indai?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124807','Estrela do Sul', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3124906','Eugen?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125002','Ewbank da C?mara', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125101','Extrema', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125200','Fama', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125309','Faria Lemos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125408','Fel?cio dos Santos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125507','S?o Gon?alo do Rio Preto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125606','Felisburgo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125705','Felixl?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125804','Fernandes Tourinho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125903','Ferros', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3125952','Fervedouro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126000','Florestal', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126109','Formiga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126208','Formoso', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126307','Fortaleza de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126406','Fortuna de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126505','Francisco Badar?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126604','Francisco Dumont', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126703','Francisco S?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126752','Francisc?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126802','Frei Gaspar', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126901','Frei Inoc?ncio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3126950','Frei Lagonegro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127008','Fronteira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127057','Fronteira dos Vales', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127073','Fruta de Leite', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127107','Frutal', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127206','Funil?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127305','Galil?ia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127339','Gameleiras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127354','Glaucil?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127370','Goiabeira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127388','Goian?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127404','Gon?alves', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127503','Gonzaga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127602','Gouveia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127701','Governador Valadares', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127800','Gr?o Mogol', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3127909','Grupiara', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128006','Guanh?es', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128105','Guap?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128204','Guaraciaba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128253','Guaraciama', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128303','Guaran?sia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128402','Guarani', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128501','Guarar?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128600','Guarda-Mor', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128709','Guaxup?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128808','Guidoval', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3128907','Guimar?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129004','Guiricema', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129103','Gurinhat?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129202','Heliodora', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129301','Iapu', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129400','Ibertioga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129509','Ibi?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129608','Ibia?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129657','Ibiracatu', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129707','Ibiraci', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129806','Ibirit?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3129905','Ibiti?ra de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130002','Ibituruna', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130051','Icara? de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130101','Igarap?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130200','Igaratinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130309','Iguatama', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130408','Ijaci', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130507','Ilic?nea', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130556','Imb? de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130606','Inconfidentes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130655','Indaiabira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130705','Indian?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130804','Inga?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3130903','Inhapim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131000','Inha?ma', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131109','Inimutaba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131158','Ipaba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131208','Ipanema', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131307','Ipatinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131406','Ipia?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131505','Ipui?na', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131604','Ira? de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131703','Itabira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131802','Itabirinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3131901','Itabirito', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132008','Itacambira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132107','Itacarambi', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132206','Itaguara', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132305','Itaip?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132404','Itajub?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132503','Itamarandiba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132602','Itamarati de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132701','Itambacuri', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132800','Itamb? do Mato Dentro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3132909','Itamogi', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133006','Itamonte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133105','Itanhandu', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133204','Itanhomi', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133303','Itaobim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133402','Itapagipe', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133501','Itapecerica', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133600','Itapeva', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133709','Itatiaiu?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133758','Ita? de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133808','Ita?na', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3133907','Itaverava', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134004','Itinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134103','Itueta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134202','Ituiutaba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134301','Itumirim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134400','Iturama', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134509','Itutinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134608','Jaboticatubas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134707','Jacinto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134806','Jacu?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3134905','Jacutinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135001','Jaguara?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135050','Ja?ba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135076','Jampruca', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135100','Jana?ba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135209','Janu?ria', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135308','Japara?ba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135357','Japonvar', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135407','Jeceaba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135456','Jenipapo de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135506','Jequeri', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135605','Jequita?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135704','Jequitib?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135803','Jequitinhonha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3135902','Jesu?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136009','Joa?ma', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136108','Joan?sia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136207','Jo?o Monlevade', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136306','Jo?o Pinheiro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136405','Joaquim Fel?cio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136504','Jord?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136520','Jos? Gon?alves de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136553','Jos? Raydan', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136579','Josen?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136603','Nova Uni?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136652','Juatuba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136702','Juiz de Fora', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136801','Juramento', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136900','Juruaia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3136959','Juven?lia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137007','Ladainha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137106','Lagamar', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137205','Lagoa da Prata', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137304','Lagoa dos Patos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137403','Lagoa Dourada', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137502','Lagoa Formosa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137536','Lagoa Grande', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137601','Lagoa Santa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137700','Lajinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137809','Lambari', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3137908','Lamim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138005','Laranjal', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138104','Lassance', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138203','Lavras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138302','Leandro Ferreira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138351','Leme do Prado', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138401','Leopoldina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138500','Liberdade', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138609','Lima Duarte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138625','Limeira do Oeste', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138658','Lontra', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138674','Luisburgo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138682','Luisl?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138708','Lumin?rias', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138807','Luz', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3138906','Machacalis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139003','Machado', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139102','Madre de Deus de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139201','Malacacheta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139250','Mamonas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139300','Manga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139409','Manhua?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139508','Manhumirim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139607','Mantena', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139706','Maravilhas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139805','Mar de Espanha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3139904','Maria da F?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140001','Mariana', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140100','Marilac', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140159','M?rio Campos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140209','Marip? de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140308','Marli?ria', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140407','Marmel?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140506','Martinho Campos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140530','Martins Soares', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140555','Mata Verde', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140605','Materl?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140704','Mateus Leme', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140803','Matias Barbosa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140852','Matias Cardoso', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3140902','Matip?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141009','Mato Verde', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141108','Matozinhos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141207','Matutina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141306','Medeiros', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141405','Medina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141504','Mendes Pimentel', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141603','Merc?s', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141702','Mesquita', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141801','Minas Novas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3141900','Minduri', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142007','Mirabela', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142106','Miradouro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142205','Mira?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142254','Mirav?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142304','Moeda', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142403','Moema', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142502','Monjolos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142601','Monsenhor Paulo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142700','Montalv?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142809','Monte Alegre de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3142908','Monte Azul', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143005','Monte Belo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143104','Monte Carmelo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143153','Monte Formoso', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143203','Monte Santo de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143302','Montes Claros', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143401','Monte Si?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143450','Montezuma', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143500','Morada Nova de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143609','Morro da Gar?a', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143708','Morro do Pilar', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143807','Munhoz', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3143906','Muria?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144003','Mutum', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144102','Muzambinho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144201','Nacip Raydan', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144300','Nanuque', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144359','Naque', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144375','Natal?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144409','Nat?rcia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144508','Nazareno', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144607','Nepomuceno', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144656','Ninheira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144672','Nova Bel?m', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144706','Nova Era', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144805','Nova Lima', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3144904','Nova M?dica', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145000','Nova Ponte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145059','Nova Porteirinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145109','Nova Resende', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145208','Nova Serrana', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145307','Novo Cruzeiro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145356','Novo Oriente de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145372','Novorizonte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145406','Olaria', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145455','Olhos-D''?gua', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145505','Ol?mpio Noronha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145604','Oliveira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145703','Oliveira Fortes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145802','On?a de Pitangui', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145851','Orat?rios', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145877','Oriz?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3145901','Ouro Branco', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146008','Ouro Fino', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146107','Ouro Preto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146206','Ouro Verde de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146255','Padre Carvalho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146305','Padre Para?so', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146404','Paineiras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146503','Pains', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146552','Pai Pedro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146602','Paiva', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146701','Palma', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146750','Palm?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3146909','Papagaios', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147006','Paracatu', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147105','Par? de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147204','Paragua?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147303','Parais?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147402','Paraopeba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147501','Passab?m', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147600','Passa Quatro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147709','Passa Tempo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147808','Passa-Vinte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147907','Passos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3147956','Patis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148004','Patos de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148103','Patroc?nio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148202','Patroc?nio do Muria?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148301','Paula C?ndido', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148400','Paulistas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148509','Pav?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148608','Pe?anha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148707','Pedra Azul', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148756','Pedra Bonita', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148806','Pedra do Anta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3148905','Pedra do Indai?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149002','Pedra Dourada', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149101','Pedralva', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149150','Pedras de Maria da Cruz', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149200','Pedrin?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149309','Pedro Leopoldo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149408','Pedro Teixeira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149507','Pequeri', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149606','Pequi', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149705','Perdig?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149804','Perdizes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149903','Perd?es', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3149952','Periquito', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150000','Pescador', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150109','Piau', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150158','Piedade de Caratinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150208','Piedade de Ponte Nova', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150307','Piedade do Rio Grande', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150406','Piedade dos Gerais', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150505','Pimenta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150539','Pingo-D''?gua', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150570','Pint?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150604','Piracema', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150703','Pirajuba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150802','Piranga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3150901','Pirangu?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151008','Piranguinho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151107','Pirapetinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151206','Pirapora', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151305','Pira?ba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151404','Pitangui', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151503','Piumhi', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151602','Planura', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151701','Po?o Fundo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151800','Po?os de Caldas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3151909','Pocrane', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152006','Pomp?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152105','Ponte Nova', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152131','Ponto Chique', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152170','Ponto dos Volantes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152204','Porteirinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152303','Porto Firme', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152402','Pot?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152501','Pouso Alegre', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152600','Pouso Alto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152709','Prados', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152808','Prata', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3152907','Prat?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153004','Pratinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153103','Presidente Bernardes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153202','Presidente Juscelino', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153301','Presidente Kubitschek', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153400','Presidente Oleg?rio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153509','Alto Jequitib?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153608','Prudente de Morais', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153707','Quartel Geral', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153806','Queluzito', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3153905','Raposos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154002','Raul Soares', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154101','Recreio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154150','Reduto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154200','Resende Costa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154309','Resplendor', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154408','Ressaquinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154457','Riachinho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154507','Riacho dos Machados', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154606','Ribeir?o das Neves', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154705','Ribeir?o Vermelho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154804','Rio Acima', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3154903','Rio Casca', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155009','Rio Doce', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155108','Rio do Prado', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155207','Rio Espera', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155306','Rio Manso', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155405','Rio Novo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155504','Rio Parana?ba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155603','Rio Pardo de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155702','Rio Piracicaba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155801','Rio Pomba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3155900','Rio Preto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156007','Rio Vermelho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156106','Rit?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156205','Rochedo de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156304','Rodeiro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156403','Romaria', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156452','Ros?rio da Limeira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156502','Rubelita', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156601','Rubim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156700','Sabar?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156809','Sabin?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3156908','Sacramento', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157005','Salinas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157104','Salto da Divisa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157203','Santa B?rbara', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157252','Santa B?rbara do Leste', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157278','Santa B?rbara do Monte Verde', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157302','Santa B?rbara do Tug?rio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157336','Santa Cruz de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157377','Santa Cruz de Salinas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157401','Santa Cruz do Escalvado', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157500','Santa Efig?nia de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157609','Santa F? de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157658','Santa Helena de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157708','Santa Juliana', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157807','Santa Luzia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3157906','Santa Margarida', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158003','Santa Maria de Itabira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158102','Santa Maria do Salto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158201','Santa Maria do Sua?u?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158300','Santana da Vargem', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158409','Santana de Cataguases', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158508','Santana de Pirapama', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158607','Santana do Deserto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158706','Santana do Garamb?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158805','Santana do Jacar?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158904','Santana do Manhua?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3158953','Santana do Para?so', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159001','Santana do Riacho', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159100','Santana dos Montes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159209','Santa Rita de Caldas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159308','Santa Rita de Jacutinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159357','Santa Rita de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159407','Santa Rita de Ibitipoca', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159506','Santa Rita do Itueto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159605','Santa Rita do Sapuca?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159704','Santa Rosa da Serra', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159803','Santa Vit?ria', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3159902','Santo Ant?nio do Amparo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160009','Santo Ant?nio do Aventureiro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160108','Santo Ant?nio do Grama', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160207','Santo Ant?nio do Itamb?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160306','Santo Ant?nio do Jacinto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160405','Santo Ant?nio do Monte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160454','Santo Ant?nio do Retiro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160504','Santo Ant?nio do Rio Abaixo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160603','Santo Hip?lito', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160702','Santos Dumont', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160801','S?o Bento Abade', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160900','S?o Br?s do Sua?u?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3160959','S?o Domingos das Dores', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161007','S?o Domingos do Prata', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161056','S?o F?lix de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161106','S?o Francisco', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161205','S?o Francisco de Paula', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161304','S?o Francisco de Sales', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161403','S?o Francisco do Gl?ria', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161502','S?o Geraldo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161601','S?o Geraldo da Piedade', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161650','S?o Geraldo do Baixio', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161700','S?o Gon?alo do Abaet?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161809','S?o Gon?alo do Par?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3161908','S?o Gon?alo do Rio Abaixo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162005','S?o Gon?alo do Sapuca?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162104','S?o Gotardo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162203','S?o Jo?o Batista do Gl?ria', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162252','S?o Jo?o da Lagoa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162302','S?o Jo?o da Mata', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162401','S?o Jo?o da Ponte', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162450','S?o Jo?o das Miss?es', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162500','S?o Jo?o del Rei', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162559','S?o Jo?o do Manhua?u', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162575','S?o Jo?o do Manteninha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162609','S?o Jo?o do Oriente', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162658','S?o Jo?o do Pacu?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162708','S?o Jo?o do Para?so', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162807','S?o Jo?o Evangelista', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162906','S?o Jo?o Nepomuceno', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162922','S?o Joaquim de Bicas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162948','S?o Jos? da Barra', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3162955','S?o Jos? da Lapa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163003','S?o Jos? da Safira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163102','S?o Jos? da Varginha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163201','S?o Jos? do Alegre', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163300','S?o Jos? do Divino', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163409','S?o Jos? do Goiabal', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163508','S?o Jos? do Jacuri', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163607','S?o Jos? do Mantimento', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163706','S?o Louren?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163805','S?o Miguel do Anta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3163904','S?o Pedro da Uni?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164001','S?o Pedro dos Ferros', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164100','S?o Pedro do Sua?u?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164209','S?o Rom?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164308','S?o Roque de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164407','S?o Sebasti?o da Bela Vista', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164431','S?o Sebasti?o da Vargem Alegre', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164472','S?o Sebasti?o do Anta', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164506','S?o Sebasti?o do Maranh?o', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164605','S?o Sebasti?o do Oeste', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164704','S?o Sebasti?o do Para?so', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164803','S?o Sebasti?o do Rio Preto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3164902','S?o Sebasti?o do Rio Verde', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165008','S?o Tiago', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165107','S?o Tom?s de Aquino', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165206','S?o Thom? das Letras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165305','S?o Vicente de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165404','Sapuca?-Mirim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165503','Sardo?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165537','Sarzedo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165552','Setubinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165560','Sem-Peixe', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165578','Senador Amaral', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165602','Senador Cortes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165701','Senador Firmino', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165800','Senador Jos? Bento', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3165909','Senador Modestino Gon?alves', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166006','Senhora de Oliveira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166105','Senhora do Porto', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166204','Senhora dos Rem?dios', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166303','Sericita', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166402','Seritinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166501','Serra Azul de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166600','Serra da Saudade', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166709','Serra dos Aimor?s', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166808','Serra do Salitre', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166907','Serrania', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3166956','Serran?polis de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167004','Serranos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167103','Serro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167202','Sete Lagoas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167301','Silveir?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167400','Silvian?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167509','Sim?o Pereira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167608','Simon?sia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167707','Sobr?lia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167806','Soledade de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3167905','Tabuleiro', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168002','Taiobeiras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168051','Taparuba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168101','Tapira', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168200','Tapira?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168309','Taquara?u de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168408','Tarumirim', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168507','Teixeiras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168606','Te?filo Otoni', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168705','Tim?teo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168804','Tiradentes', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3168903','Tiros', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169000','Tocantins', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169059','Tocos do Moji', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169109','Toledo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169208','Tombos', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169307','Tr?s Cora??es', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169356','Tr?s Marias', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169406','Tr?s Pontas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169505','Tumiritinga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169604','Tupaciguara', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169703','Turmalina', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169802','Turvol?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3169901','Ub?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170008','Uba?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170057','Ubaporanga', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170107','Uberaba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170206','Uberl?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170305','Umburatiba', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170404','Una?', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170438','Uni?o de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170479','Uruana de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170503','Uruc?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170529','Urucuia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170578','Vargem Alegre', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170602','Vargem Bonita', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170651','Vargem Grande do Rio Pardo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170701','Varginha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170750','Varj?o de Minas', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170800','V?rzea da Palma', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3170909','Varzel?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171006','Vazante', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171030','Verdel?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171071','Veredinha', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171105','Ver?ssimo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171154','Vermelho Novo', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171204','Vespasiano', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171303','Vi?osa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171402','Vieiras', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171501','Mathias Lobato', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171600','Virgem da Lapa', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171709','Virg?nia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171808','Virgin?polis', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3171907','Virgol?ndia', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3172004','Visconde do Rio Branco', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3172103','Volta Grande', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3172202','Wenceslau Braz', 31);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200102','Afonso Cl?udio', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200136','?guia Branca', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200169','?gua Doce do Norte', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200201','Alegre', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200300','Alfredo Chaves', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200359','Alto Rio Novo', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200409','Anchieta', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200508','Apiac?', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200607','Aracruz', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200706','Atilio Vivacqua', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200805','Baixo Guandu', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3200904','Barra de S?o Francisco', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201001','Boa Esperan?a', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201100','Bom Jesus do Norte', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201159','Brejetuba', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201209','Cachoeiro de Itapemirim', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201308','Cariacica', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201407','Castelo', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201506','Colatina', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201605','Concei??o da Barra', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201704','Concei??o do Castelo', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201803','Divino de S?o Louren?o', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3201902','Domingos Martins', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202009','Dores do Rio Preto', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202108','Ecoporanga', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202207','Fund?o', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202256','Governador Lindenberg', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202306','Gua?u?', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202405','Guarapari', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202454','Ibatiba', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202504','Ibira?u', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202553','Ibitirama', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202603','Iconha', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202652','Irupi', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202702','Itagua?u', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202801','Itapemirim', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3202900','Itarana', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203007','I?na', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203056','Jaguar?', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203106','Jer?nimo Monteiro', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203130','Jo?o Neiva', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203163','Laranja da Terra', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203205','Linhares', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203304','Manten?polis', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203320','Marata?zes', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203346','Marechal Floriano', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203353','Maril?ndia', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203403','Mimoso do Sul', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203502','Montanha', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203601','Mucurici', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203700','Muniz Freire', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203809','Muqui', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3203908','Nova Ven?cia', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204005','Pancas', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204054','Pedro Can?rio', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204104','Pinheiros', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204203','Pi?ma', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204252','Ponto Belo', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204302','Presidente Kennedy', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204351','Rio Bananal', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204401','Rio Novo do Sul', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204500','Santa Leopoldina', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204559','Santa Maria de Jetib?', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204609','Santa Teresa', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204658','S?o Domingos do Norte', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204708','S?o Gabriel da Palha', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204807','S?o Jos? do Cal?ado', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204906','S?o Mateus', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3204955','S?o Roque do Cana?', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205002','Serra', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205010','Sooretama', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205036','Vargem Alta', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205069','Venda Nova do Imigrante', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205101','Viana', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205150','Vila Pav?o', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205176','Vila Val?rio', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205200','Vila Velha', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3205309','Vit?ria', 32);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300100','Angra dos Reis', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300159','Aperib?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300209','Araruama', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300225','Areal', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300233','Arma??o dos B?zios', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300258','Arraial do Cabo', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300308','Barra do Pira?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300407','Barra Mansa', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300456','Belford Roxo', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300506','Bom Jardim', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300605','Bom Jesus do Itabapoana', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300704','Cabo Frio', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300803','Cachoeiras de Macacu', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300902','Cambuci', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300936','Carapebus', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3300951','Comendador Levy Gasparian', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301009','Campos dos Goytacazes', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301108','Cantagalo', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301157','Cardoso Moreira', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301207','Carmo', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301306','Casimiro de Abreu', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301405','Concei??o de Macabu', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301504','Cordeiro', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301603','Duas Barras', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301702','Duque de Caxias', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301801','Engenheiro Paulo de Frontin', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301850','Guapimirim', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301876','Iguaba Grande', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3301900','Itabora?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302007','Itagua?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302056','Italva', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302106','Itaocara', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302205','Itaperuna', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302254','Itatiaia', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302270','Japeri', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302304','Laje do Muria?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302403','Maca?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302452','Macuco', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302502','Mag?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302601','Mangaratiba', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302700','Maric?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302809','Mendes', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302858','Mesquita', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3302908','Miguel Pereira', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303005','Miracema', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303104','Natividade', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303203','Nil?polis', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303302','Niter?i', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303401','Nova Friburgo', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303500','Nova Igua?u', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303609','Paracambi', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303708','Para?ba do Sul', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303807','Paraty', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303856','Paty do Alferes', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303906','Petr?polis', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3303955','Pinheiral', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304003','Pira?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304102','Porci?ncula', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304110','Porto Real', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304128','Quatis', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304144','Queimados', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304151','Quissam?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304201','Resende', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304300','Rio Bonito', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304409','Rio Claro', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304508','Rio das Flores', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304524','Rio das Ostras', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304557','Rio de Janeiro', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304607','Santa Maria Madalena', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304706','Santo Ant?nio de P?dua', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304755','S?o Francisco de Itabapoana', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304805','S?o Fid?lis', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3304904','S?o Gon?alo', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305000','S?o Jo?o da Barra', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305109','S?o Jo?o de Meriti', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305133','S?o Jos? de Ub?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305158','S?o Jos? do Vale do Rio Preto', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305208','S?o Pedro da Aldeia', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305307','S?o Sebasti?o do Alto', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305406','Sapucaia', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305505','Saquarema', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305554','Serop?dica', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305604','Silva Jardim', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305703','Sumidouro', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305752','Tangu?', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305802','Teres?polis', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3305901','Trajano de Moraes', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3306008','Tr?s Rios', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3306107','Valen?a', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3306156','Varre-Sai', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3306206','Vassouras', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3306305','Volta Redonda', 33);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500105','Adamantina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500204','Adolfo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500303','Agua?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500402','?guas da Prata', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500501','?guas de Lind?ia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500550','?guas de Santa B?rbara', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500600','?guas de S?o Pedro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500709','Agudos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500758','Alambari', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500808','Alfredo Marcondes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3500907','Altair', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501004','Altin?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501103','Alto Alegre', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501152','Alum?nio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501202','?lvares Florence', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501301','?lvares Machado', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501400','?lvaro de Carvalho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501509','Alvinl?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501608','Americana', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501707','Am?rico Brasiliense', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501806','Am?rico de Campos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3501905','Amparo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502002','Anal?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502101','Andradina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502200','Angatuba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502309','Anhembi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502408','Anhumas', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502507','Aparecida', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502606','Aparecida D''Oeste', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502705','Apia?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502754','Ara?ariguama', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502804','Ara?atuba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3502903','Ara?oiaba da Serra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503000','Aramina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503109','Arandu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503158','Arape?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503208','Araraquara', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503307','Araras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503356','Arco-?ris', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503406','Arealva', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503505','Areias', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503604','Arei?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503703','Ariranha', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503802','Artur Nogueira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503901','Aruj?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3503950','Asp?sia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504008','Assis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504107','Atibaia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504206','Auriflama', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504305','Ava?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504404','Avanhandava', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504503','Avar?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504602','Bady Bassitt', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504701','Balbinos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504800','B?lsamo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3504909','Bananal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505005','Bar?o de Antonina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505104','Barbosa', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505203','Bariri', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505302','Barra Bonita', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505351','Barra do Chap?u', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505401','Barra do Turvo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505500','Barretos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505609','Barrinha', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505708','Barueri', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505807','Bastos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3505906','Batatais', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506003','Bauru', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506102','Bebedouro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506201','Bento de Abreu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506300','Bernardino de Campos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506359','Bertioga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506409','Bilac', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506508','Birigui', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506607','Biritiba-Mirim', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506706','Boa Esperan?a do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506805','Bocaina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3506904','Bofete', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507001','Boituva', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507100','Bom Jesus dos Perd?es', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507159','Bom Sucesso de Itarar?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507209','Bor?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507308','Borac?ia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507407','Borborema', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507456','Borebi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507506','Botucatu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507605','Bragan?a Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507704','Bra?na', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507753','Brejo Alegre', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507803','Brodowski', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3507902','Brotas', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508009','Buri', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508108','Buritama', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508207','Buritizal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508306','Cabr?lia Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508405','Cabre?va', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508504','Ca?apava', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508603','Cachoeira Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508702','Caconde', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508801','Cafel?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3508900','Caiabu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509007','Caieiras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509106','Caiu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509205','Cajamar', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509254','Cajati', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509304','Cajobi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509403','Cajuru', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509452','Campina do Monte Alegre', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509502','Campinas', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509601','Campo Limpo Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509700','Campos do Jord?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509809','Campos Novos Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509908','Canan?ia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3509957','Canas', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510005','C?ndido Mota', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510104','C?ndido Rodrigues', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510153','Canitar', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510203','Cap?o Bonito', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510302','Capela do Alto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510401','Capivari', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510500','Caraguatatuba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510609','Carapicu?ba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510708','Cardoso', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510807','Casa Branca', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3510906','C?ssia dos Coqueiros', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511003','Castilho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511102','Catanduva', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511201','Catigu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511300','Cedral', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511409','Cerqueira C?sar', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511508','Cerquilho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511607','Ces?rio Lange', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511706','Charqueada', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3511904','Clementina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512001','Colina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512100','Col?mbia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512209','Conchal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512308','Conchas', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512407','Cordeir?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512506','Coroados', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512605','Coronel Macedo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512704','Corumbata?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512803','Cosm?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3512902','Cosmorama', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513009','Cotia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513108','Cravinhos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513207','Cristais Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513306','Cruz?lia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513405','Cruzeiro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513504','Cubat?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513603','Cunha', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513702','Descalvado', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513801','Diadema', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513850','Dirce Reis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3513900','Divinol?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514007','Dobrada', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514106','Dois C?rregos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514205','Dolcin?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514304','Dourado', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514403','Dracena', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514502','Duartina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514601','Dumont', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514700','Echapor?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514809','Eldorado', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514908','Elias Fausto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514924','Elisi?rio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3514957','Emba?ba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515004','Embu das Artes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515103','Embu-Gua?u', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515129','Emilian?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515152','Engenheiro Coelho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515186','Esp?rito Santo do Pinhal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515194','Esp?rito Santo do Turvo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515202','Estrela D''Oeste', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515301','Estrela do Norte', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515350','Euclides da Cunha Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515400','Fartura', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515509','Fernand?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515608','Fernando Prestes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515657','Fern?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515707','Ferraz de Vasconcelos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515806','Flora Rica', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3515905','Floreal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516002','Fl?rida Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516101','Flor?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516200','Franca', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516309','Francisco Morato', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516408','Franco da Rocha', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516507','Gabriel Monteiro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516606','G?lia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516705','Gar?a', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516804','Gast?o Vidigal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516853','Gavi?o Peixoto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3516903','General Salgado', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517000','Getulina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517109','Glic?rio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517208','Guai?ara', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517307','Guaimb?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517406','Gua?ra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517505','Guapia?u', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517604','Guapiara', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517703','Guar?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517802','Guara?a?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3517901','Guaraci', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518008','Guarani D''Oeste', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518107','Guarant?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518206','Guararapes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518305','Guararema', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518404','Guaratinguet?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518503','Guare?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518602','Guariba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518701','Guaruj?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518800','Guarulhos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518859','Guatapar?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3518909','Guzol?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519006','Hercul?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519055','Holambra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519071','Hortol?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519105','Iacanga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519204','Iacri', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519253','Iaras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519303','Ibat?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519402','Ibir?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519501','Ibirarema', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519600','Ibitinga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519709','Ibi?na', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519808','Ic?m', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3519907','Iep?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520004','Igara?u do Tiet?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520103','Igarapava', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520202','Igarat?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520301','Iguape', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520400','Ilhabela', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520426','Ilha Comprida', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520442','Ilha Solteira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520509','Indaiatuba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520608','Indiana', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520707','Indiapor?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520806','In?bia Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3520905','Ipaussu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521002','Iper?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521101','Ipe?na', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521150','Ipigu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521200','Iporanga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521309','Ipu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521408','Iracem?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521507','Irapu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521606','Irapuru', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521705','Itaber?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521804','Ita?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3521903','Itajobi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522000','Itaju', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522109','Itanha?m', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522158','Ita?ca', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522208','Itapecerica da Serra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522307','Itapetininga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522406','Itapeva', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522505','Itapevi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522604','Itapira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522653','Itapirapu? Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522703','It?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522802','Itaporanga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3522901','Itapu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523008','Itapura', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523107','Itaquaquecetuba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523206','Itarar?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523305','Itariri', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523404','Itatiba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523503','Itatinga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523602','Itirapina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523701','Itirapu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523800','Itobi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3523909','Itu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524006','Itupeva', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524105','Ituverava', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524204','Jaborandi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524303','Jaboticabal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524402','Jacare?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524501','Jaci', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524600','Jacupiranga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524709','Jaguari?na', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524808','Jales', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3524907','Jambeiro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525003','Jandira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525102','Jardin?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525201','Jarinu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525300','Ja?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525409','Jeriquara', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525508','Joan?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525607','Jo?o Ramalho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525706','Jos? Bonif?cio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525805','J?lio Mesquita', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525854','Jumirim', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3525904','Jundia?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526001','Junqueir?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526100','Juqui?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526209','Juquitiba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526308','Lagoinha', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526407','Laranjal Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526506','Lav?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526605','Lavrinhas', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526704','Leme', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526803','Len??is Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3526902','Limeira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527009','Lind?ia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527108','Lins', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527207','Lorena', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527256','Lourdes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527306','Louveira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527405','Luc?lia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527504','Lucian?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527603','Lu?s Ant?nio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527702','Luizi?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527801','Lup?rcio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3527900','Lut?cia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528007','Macatuba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528106','Macaubal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528205','Maced?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528304','Magda', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528403','Mairinque', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528502','Mairipor?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528601','Manduri', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528700','Marab? Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528809','Maraca?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528858','Marapoama', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3528908','Mari?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529005','Mar?lia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529104','Marin?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529203','Martin?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529302','Mat?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529401','Mau?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529500','Mendon?a', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529609','Meridiano', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529658','Mes?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529708','Miguel?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529807','Mineiros do Tiet?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3529906','Miracatu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530003','Mira Estrela', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530102','Mirand?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530201','Mirante do Paranapanema', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530300','Mirassol', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530409','Mirassol?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530508','Mococa', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530607','Mogi das Cruzes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530706','Mogi Gua?u', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530805','Moji Mirim', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3530904','Mombuca', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531001','Mon??es', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531100','Mongagu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531209','Monte Alegre do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531308','Monte Alto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531407','Monte Apraz?vel', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531506','Monte Azul Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531605','Monte Castelo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531704','Monteiro Lobato', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531803','Monte Mor', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3531902','Morro Agudo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532009','Morungaba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532058','Motuca', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532108','Murutinga do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532157','Nantes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532207','Narandiba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532306','Natividade da Serra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532405','Nazar? Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532504','Neves Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532603','Nhandeara', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532702','Nipo?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532801','Nova Alian?a', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532827','Nova Campina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532843','Nova Cana? Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532868','Nova Castilho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3532900','Nova Europa', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533007','Nova Granada', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533106','Nova Guataporanga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533205','Nova Independ?ncia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533254','Novais', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533304','Nova Luzit?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533403','Nova Odessa', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533502','Novo Horizonte', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533601','Nuporanga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533700','Ocau?u', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533809','?leo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3533908','Ol?mpia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534005','Onda Verde', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534104','Oriente', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534203','Orindi?va', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534302','Orl?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534401','Osasco', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534500','Oscar Bressane', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534609','Osvaldo Cruz', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534708','Ourinhos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534757','Ouroeste', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534807','Ouro Verde', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3534906','Pacaembu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535002','Palestina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535101','Palmares Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535200','Palmeira D''Oeste', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535309','Palmital', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535408','Panorama', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535507','Paragua?u Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535606','Paraibuna', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535705','Para?so', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535804','Paranapanema', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3535903','Paranapu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536000','Parapu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536109','Pardinho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536208','Pariquera-A?u', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536257','Parisi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536307','Patroc?nio Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536406','Paulic?ia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536505','Paul?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536570','Paulist?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536604','Paulo de Faria', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536703','Pederneiras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536802','Pedra Bela', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3536901','Pedran?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537008','Pedregulho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537107','Pedreira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537156','Pedrinhas Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537206','Pedro de Toledo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537305','Pen?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537404','Pereira Barreto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537503','Pereiras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537602','Peru?be', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537701','Piacatu', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537800','Piedade', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3537909','Pilar do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538006','Pindamonhangaba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538105','Pindorama', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538204','Pinhalzinho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538303','Piquerobi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538501','Piquete', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538600','Piracaia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538709','Piracicaba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538808','Piraju', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3538907','Piraju?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539004','Pirangi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539103','Pirapora do Bom Jesus', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539202','Pirapozinho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539301','Pirassununga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539400','Piratininga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539509','Pitangueiras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539608','Planalto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539707','Platina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539806','Po?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3539905','Poloni', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540002','Pomp?ia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540101','Ponga?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540200','Pontal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540259','Pontalinda', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540309','Pontes Gestal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540408','Populina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540507','Porangaba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540606','Porto Feliz', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540705','Porto Ferreira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540754','Potim', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540804','Potirendaba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540853','Pracinha', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3540903','Prad?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541000','Praia Grande', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541059','Prat?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541109','Presidente Alves', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541208','Presidente Bernardes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541307','Presidente Epit?cio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541406','Presidente Prudente', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541505','Presidente Venceslau', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541604','Promiss?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541653','Quadra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541703','Quat?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541802','Queiroz', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3541901','Queluz', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542008','Quintana', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542107','Rafard', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542206','Rancharia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542305','Reden??o da Serra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542404','Regente Feij?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542503','Regin?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542602','Registro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542701','Restinga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542800','Ribeira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3542909','Ribeir?o Bonito', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543006','Ribeir?o Branco', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543105','Ribeir?o Corrente', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543204','Ribeir?o do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543238','Ribeir?o dos ?ndios', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543253','Ribeir?o Grande', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543303','Ribeir?o Pires', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543402','Ribeir?o Preto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543501','Riversul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543600','Rifaina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543709','Rinc?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543808','Rin?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3543907','Rio Claro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544004','Rio das Pedras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544103','Rio Grande da Serra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544202','Riol?ndia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544251','Rosana', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544301','Roseira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544400','Rubi?cea', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544509','Rubin?ia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544608','Sabino', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544707','Sagres', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544806','Sales', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3544905','Sales Oliveira', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545001','Sales?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545100','Salmour?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545159','Saltinho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545209','Salto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545308','Salto de Pirapora', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545407','Salto Grande', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545506','Sandovalina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545605','Santa Ad?lia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545704','Santa Albertina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3545803','Santa B?rbara D''Oeste', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546009','Santa Branca', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546108','Santa Clara D''Oeste', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546207','Santa Cruz da Concei??o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546256','Santa Cruz da Esperan?a', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546306','Santa Cruz das Palmeiras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546405','Santa Cruz do Rio Pardo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546504','Santa Ernestina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546603','Santa F? do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546702','Santa Gertrudes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546801','Santa Isabel', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3546900','Santa L?cia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547007','Santa Maria da Serra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547106','Santa Mercedes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547205','Santana da Ponte Pensa', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547304','Santana de Parna?ba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547403','Santa Rita D''Oeste', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547502','Santa Rita do Passa Quatro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547601','Santa Rosa de Viterbo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547650','Santa Salete', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547700','Santo Anast?cio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547809','Santo Andr?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3547908','Santo Ant?nio da Alegria', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548005','Santo Ant?nio de Posse', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548054','Santo Ant?nio do Aracangu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548104','Santo Ant?nio do Jardim', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548203','Santo Ant?nio do Pinhal', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548302','Santo Expedito', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548401','Sant?polis do Aguape?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548500','Santos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548609','S?o Bento do Sapuca?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548708','S?o Bernardo do Campo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548807','S?o Caetano do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3548906','S?o Carlos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549003','S?o Francisco', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549102','S?o Jo?o da Boa Vista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549201','S?o Jo?o das Duas Pontes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549250','S?o Jo?o de Iracema', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549300','S?o Jo?o do Pau D''Alho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549409','S?o Joaquim da Barra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549508','S?o Jos? da Bela Vista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549607','S?o Jos? do Barreiro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549706','S?o Jos? do Rio Pardo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549805','S?o Jos? do Rio Preto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549904','S?o Jos? dos Campos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3549953','S?o Louren?o da Serra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550001','S?o Lu?s do Paraitinga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550100','S?o Manuel', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550209','S?o Miguel Arcanjo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550308','S?o Paulo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550407','S?o Pedro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550506','S?o Pedro do Turvo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550605','S?o Roque', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550704','S?o Sebasti?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550803','S?o Sebasti?o da Grama', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3550902','S?o Sim?o', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551009','S?o Vicente', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551108','Sarapu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551207','Sarutai?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551306','Sebastian?polis do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551405','Serra Azul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551504','Serrana', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551603','Serra Negra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551702','Sert?ozinho', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551801','Sete Barras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3551900','Sever?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552007','Silveiras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552106','Socorro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552205','Sorocaba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552304','Sud Mennucci', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552403','Sumar?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552502','Suzano', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552551','Suzan?polis', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552601','Tabapu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552700','Tabatinga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552809','Tabo?o da Serra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3552908','Taciba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553005','Tagua?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553104','Taia?u', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553203','Tai?va', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553302','Tamba?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553401','Tanabi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553500','Tapira?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553609','Tapiratiba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553658','Taquaral', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553708','Taquaritinga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553807','Taquarituba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553856','Taquariva?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553906','Tarabai', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3553955','Tarum?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554003','Tatu?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554102','Taubat?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554201','Tejup?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554300','Teodoro Sampaio', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554409','Terra Roxa', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554508','Tiet?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554607','Timburi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554656','Torre de Pedra', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554706','Torrinha', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554755','Trabiju', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554805','Trememb?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554904','Tr?s Fronteiras', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3554953','Tuiuti', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555000','Tup?', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555109','Tupi Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555208','Turi?ba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555307','Turmalina', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555356','Ubarana', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555406','Ubatuba', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555505','Ubirajara', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555604','Uchoa', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555703','Uni?o Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555802','Ur?nia', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3555901','Uru', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556008','Urup?s', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556107','Valentim Gentil', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556206','Valinhos', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556305','Valpara?so', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556354','Vargem', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556404','Vargem Grande do Sul', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556453','Vargem Grande Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556503','V?rzea Paulista', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556602','Vera Cruz', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556701','Vinhedo', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556800','Viradouro', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556909','Vista Alegre do Alto', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3556958','Vit?ria Brasil', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3557006','Votorantim', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3557105','Votuporanga', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3557154','Zacarias', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3557204','Chavantes', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('3557303','Estiva Gerbi', 35);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100103','Abati?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100202','Adrian?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100301','Agudos do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100400','Almirante Tamandar?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100459','Altamira do Paran?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100509','Alt?nia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100608','Alto Paran?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100707','Alto Piquiri', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100806','Alvorada do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4100905','Amapor?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101002','Amp?re', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101051','Anahy', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101101','Andir?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101150','?ngulo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101200','Antonina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101309','Ant?nio Olinto', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101408','Apucarana', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101507','Arapongas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101606','Arapoti', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101655','Arapu?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101705','Araruna', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101804','Arauc?ria', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101853','Ariranha do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4101903','Assa?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102000','Assis Chateaubriand', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102109','Astorga', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102208','Atalaia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102307','Balsa Nova', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102406','Bandeirantes', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102505','Barbosa Ferraz', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102604','Barrac?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102703','Barra do Jacar?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102752','Bela Vista da Caroba', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102802','Bela Vista do Para?so', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4102901','Bituruna', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103008','Boa Esperan?a', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103024','Boa Esperan?a do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103040','Boa Ventura de S?o Roque', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103057','Boa Vista da Aparecida', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103107','Bocai?va do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103156','Bom Jesus do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103206','Bom Sucesso', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103222','Bom Sucesso do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103305','Borraz?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103354','Braganey', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103370','Brasil?ndia do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103404','Cafeara', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103453','Cafel?ndia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103479','Cafezal do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103503','Calif?rnia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103602','Cambar?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103701','Camb?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103800','Cambira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103909','Campina da Lagoa', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4103958','Campina do Sim?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104006','Campina Grande do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104055','Campo Bonito', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104105','Campo do Tenente', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104204','Campo Largo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104253','Campo Magro', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104303','Campo Mour?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104402','C?ndido de Abreu', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104428','Cand?i', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104451','Cantagalo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104501','Capanema', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104600','Capit?o Le?nidas Marques', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104659','Carambe?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104709','Carl?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104808','Cascavel', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4104907','Castro', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105003','Catanduvas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105102','Centen?rio do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105201','Cerro Azul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105300','C?u Azul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105409','Chopinzinho', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105508','Cianorte', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105607','Cidade Ga?cha', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105706','Clevel?ndia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105805','Colombo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4105904','Colorado', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106001','Congonhinhas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106100','Conselheiro Mairinck', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106209','Contenda', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106308','Corb?lia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106407','Corn?lio Proc?pio', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106456','Coronel Domingos Soares', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106506','Coronel Vivida', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106555','Corumbata? do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106571','Cruzeiro do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106605','Cruzeiro do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106704','Cruzeiro do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106803','Cruz Machado', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106852','Cruzmaltina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4106902','Curitiba', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107009','Curi?va', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107108','Diamante do Norte', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107124','Diamante do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107157','Diamante D''Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107207','Dois Vizinhos', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107256','Douradina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107306','Doutor Camargo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107405','En?as Marques', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107504','Engenheiro Beltr?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107520','Esperan?a Nova', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107538','Entre Rios do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107546','Espig?o Alto do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107553','Farol', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107603','Faxinal', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107652','Fazenda Rio Grande', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107702','F?nix', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107736','Fernandes Pinheiro', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107751','Figueira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107801','Flora?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107850','Flor da Serra do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4107900','Floresta', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108007','Florest?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108106','Fl?rida', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108205','Formosa do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108304','Foz do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108320','Francisco Alves', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108403','Francisco Beltr?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108452','Foz do Jord?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108502','General Carneiro', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108551','Godoy Moreira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108601','Goioer?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108650','Goioxim', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108700','Grandes Rios', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108809','Gua?ra', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108908','Guaira??', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4108957','Guamiranga', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109005','Guapirama', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109104','Guaporema', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109203','Guaraci', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109302','Guarania?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109401','Guarapuava', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109500','Guaraque?aba', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109609','Guaratuba', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109658','Hon?rio Serpa', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109708','Ibaiti', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109757','Ibema', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109807','Ibipor?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4109906','Icara?ma', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110003','Iguara?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110052','Iguatu', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110078','Imba?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110102','Imbituva', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110201','In?cio Martins', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110300','Inaj?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110409','Indian?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110508','Ipiranga', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110607','Ipor?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110656','Iracema do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110706','Irati', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110805','Iretama', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110904','Itaguaj?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4110953','Itaipul?ndia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111001','Itambarac?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111100','Itamb?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111209','Itapejara D''Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111258','Itaperu?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111308','Ita?na do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111407','Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111506','Ivaipor?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111555','Ivat?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111605','Ivatuba', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111704','Jaboti', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111803','Jacarezinho', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4111902','Jaguapit?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112009','Jaguaria?va', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112108','Jandaia do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112207','Jani?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112306','Japira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112405','Japur?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112504','Jardim Alegre', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112603','Jardim Olinda', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112702','Jataizinho', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112751','Jesu?tas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112801','Joaquim T?vora', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112900','Jundia? do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4112959','Juranda', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113007','Jussara', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113106','Kalor?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113205','Lapa', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113254','Laranjal', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113304','Laranjeiras do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113403','Le?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113429','Lidian?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113452','Lindoeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113502','Loanda', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113601','Lobato', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113700','Londrina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113734','Luiziana', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113759','Lunardelli', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113809','Lupion?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4113908','Mallet', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114005','Mambor?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114104','Mandagua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114203','Mandaguari', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114302','Mandirituba', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114351','Manfrin?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114401','Mangueirinha', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114500','Manoel Ribas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114609','Marechal C?ndido Rondon', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114708','Maria Helena', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114807','Marialva', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4114906','Maril?ndia do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115002','Marilena', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115101','Mariluz', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115200','Maring?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115309','Mari?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115358','Marip?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115408','Marmeleiro', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115457','Marquinho', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115507','Marumbi', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115606','Matel?ndia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115705','Matinhos', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115739','Mato Rico', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115754','Mau? da Serra', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115804','Medianeira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115853','Mercedes', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4115903','Mirador', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116000','Miraselva', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116059','Missal', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116109','Moreira Sales', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116208','Morretes', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116307','Munhoz de Melo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116406','Nossa Senhora das Gra?as', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116505','Nova Alian?a do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116604','Nova Am?rica da Colina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116703','Nova Aurora', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116802','Nova Cantu', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116901','Nova Esperan?a', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4116950','Nova Esperan?a do Sudoeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117008','Nova F?tima', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117057','Nova Laranjeiras', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117107','Nova Londrina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117206','Nova Ol?mpia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117214','Nova Santa B?rbara', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117222','Nova Santa Rosa', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117255','Nova Prata do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117271','Nova Tebas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117297','Novo Itacolomi', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117305','Ortigueira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117404','Ourizona', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117453','Ouro Verde do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117503','Pai?andu', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117602','Palmas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117701','Palmeira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117800','Palmital', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4117909','Palotina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118006','Para?so do Norte', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118105','Paranacity', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118204','Paranagu?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118303','Paranapoema', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118402','Paranava?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118451','Pato Bragado', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118501','Pato Branco', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118600','Paula Freitas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118709','Paulo Frontin', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118808','Peabiru', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118857','Perobal', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4118907','P?rola', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119004','P?rola D''Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119103','Pi?n', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119152','Pinhais', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119202','Pinhal?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119251','Pinhal de S?o Bento', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119301','Pinh?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119400','Pira? do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119509','Piraquara', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119608','Pitanga', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119657','Pitangueiras', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119707','Planaltina do Paran?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119806','Planalto', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119905','Ponta Grossa', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4119954','Pontal do Paran?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120002','Porecatu', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120101','Porto Amazonas', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120150','Porto Barreiro', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120200','Porto Rico', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120309','Porto Vit?ria', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120333','Prado Ferreira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120358','Pranchita', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120408','Presidente Castelo Branco', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120507','Primeiro de Maio', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120606','Prudent?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120655','Quarto Centen?rio', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120705','Quatigu?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120804','Quatro Barras', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120853','Quatro Pontes', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4120903','Quedas do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121000','Quer?ncia do Norte', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121109','Quinta do Sol', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121208','Quitandinha', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121257','Ramil?ndia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121307','Rancho Alegre', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121356','Rancho Alegre D''Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121406','Realeza', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121505','Rebou?as', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121604','Renascen?a', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121703','Reserva', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121752','Reserva do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121802','Ribeir?o Claro', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4121901','Ribeir?o do Pinhal', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122008','Rio Azul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122107','Rio Bom', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122156','Rio Bonito do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122172','Rio Branco do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122206','Rio Branco do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122305','Rio Negro', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122404','Rol?ndia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122503','Roncador', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122602','Rondon', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122651','Ros?rio do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122701','Sab?udia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122800','Salgado Filho', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4122909','Salto do Itarar?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123006','Salto do Lontra', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123105','Santa Am?lia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123204','Santa Cec?lia do Pav?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123303','Santa Cruz de Monte Castelo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123402','Santa F?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123501','Santa Helena', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123600','Santa In?s', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123709','Santa Isabel do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123808','Santa Izabel do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123824','Santa L?cia', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123857','Santa Maria do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123907','Santa Mariana', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4123956','Santa M?nica', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124004','Santana do Itarar?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124020','Santa Tereza do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124053','Santa Terezinha de Itaipu', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124103','Santo Ant?nio da Platina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124202','Santo Ant?nio do Caiu?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124301','Santo Ant?nio do Para?so', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124400','Santo Ant?nio do Sudoeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124509','Santo In?cio', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124608','S?o Carlos do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124707','S?o Jer?nimo da Serra', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124806','S?o Jo?o', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4124905','S?o Jo?o do Caiu?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125001','S?o Jo?o do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125100','S?o Jo?o do Triunfo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125209','S?o Jorge D''Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125308','S?o Jorge do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125357','S?o Jorge do Patroc?nio', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125407','S?o Jos? da Boa Vista', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125456','S?o Jos? das Palmeiras', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125506','S?o Jos? dos Pinhais', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125555','S?o Manoel do Paran?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125605','S?o Mateus do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125704','S?o Miguel do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125753','S?o Pedro do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125803','S?o Pedro do Iva?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4125902','S?o Pedro do Paran?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126009','S?o Sebasti?o da Amoreira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126108','S?o Tom?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126207','Sapopema', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126256','Sarandi', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126272','Saudade do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126306','Seng?s', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126355','Serran?polis do Igua?u', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126405','Sertaneja', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126504','Sertan?polis', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126603','Siqueira Campos', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126652','Sulina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126678','Tamarana', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126702','Tamboara', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126801','Tapejara', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4126900','Tapira', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127007','Teixeira Soares', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127106','Tel?maco Borba', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127205','Terra Boa', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127304','Terra Rica', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127403','Terra Roxa', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127502','Tibagi', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127601','Tijucas do Sul', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127700','Toledo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127809','Tomazina', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127858','Tr?s Barras do Paran?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127882','Tunas do Paran?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127908','Tuneiras do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127957','Tup?ssi', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4127965','Turvo', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128005','Ubirat?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128104','Umuarama', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128203','Uni?o da Vit?ria', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128302','Uniflor', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128401','Ura?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128500','Wenceslau Braz', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128534','Ventania', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128559','Vera Cruz do Oeste', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128609','Ver?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128625','Alto Para?so', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128633','Doutor Ulysses', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128658','Virmond', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128708','Vitorino', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4128807','Xambr?', 41);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200051','Abdon Batista', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200101','Abelardo Luz', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200200','Agrol?ndia', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200309','Agron?mica', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200408','?gua Doce', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200507','?guas de Chapec?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200556','?guas Frias', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200606','?guas Mornas', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200705','Alfredo Wagner', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200754','Alto Bela Vista', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200804','Anchieta', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4200903','Angelina', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201000','Anita Garibaldi', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201109','Anit?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201208','Ant?nio Carlos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201257','Api?na', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201273','Arabut?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201307','Araquari', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201406','Ararangu?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201505','Armaz?m', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201604','Arroio Trinta', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201653','Arvoredo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201703','Ascurra', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201802','Atalanta', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201901','Aurora', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4201950','Balne?rio Arroio do Silva', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202008','Balne?rio Cambori?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202057','Balne?rio Barra do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202073','Balne?rio Gaivota', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202081','Bandeirante', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202099','Barra Bonita', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202107','Barra Velha', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202131','Bela Vista do Toldo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202156','Belmonte', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202206','Benedito Novo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202305','Bigua?u', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202404','Blumenau', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202438','Bocaina do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202453','Bombinhas', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202503','Bom Jardim da Serra', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202537','Bom Jesus', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202578','Bom Jesus do Oeste', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202602','Bom Retiro', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202701','Botuver?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202800','Bra?o do Norte', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202859','Bra?o do Trombudo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202875','Brun?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4202909','Brusque', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203006','Ca?ador', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203105','Caibi', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203154','Calmon', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203204','Cambori?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203253','Cap?o Alto', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203303','Campo Alegre', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203402','Campo Belo do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203501','Campo Er?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203600','Campos Novos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203709','Canelinha', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203808','Canoinhas', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203907','Capinzal', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4203956','Capivari de Baixo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204004','Catanduvas', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204103','Caxambu do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204152','Celso Ramos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204178','Cerro Negro', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204194','Chapad?o do Lageado', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204202','Chapec?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204251','Cocal do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204301','Conc?rdia', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204350','Cordilheira Alta', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204400','Coronel Freitas', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204459','Coronel Martins', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204509','Corup?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204558','Correia Pinto', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204608','Crici?ma', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204707','Cunha Por?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204756','Cunhata?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204806','Curitibanos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4204905','Descanso', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205001','Dion?sio Cerqueira', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205100','Dona Emma', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205159','Doutor Pedrinho', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205175','Entre Rios', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205191','Ermo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205209','Erval Velho', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205308','Faxinal dos Guedes', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205357','Flor do Sert?o', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205407','Florian?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205431','Formosa do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205456','Forquilhinha', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205506','Fraiburgo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205555','Frei Rog?rio', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205605','Galv?o', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205704','Garopaba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205803','Garuva', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4205902','Gaspar', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206009','Governador Celso Ramos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206108','Gr?o Par?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206207','Gravatal', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206306','Guabiruba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206405','Guaraciaba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206504','Guaramirim', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206603','Guaruj? do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206652','Guatamb?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206702','Herval D''Oeste', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206751','Ibiam', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206801','Ibicar?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4206900','Ibirama', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207007','I?ara', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207106','Ilhota', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207205','Imaru?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207304','Imbituba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207403','Imbuia', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207502','Indaial', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207577','Iomer?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207601','Ipira', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207650','Ipor? do Oeste', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207684','Ipua?u', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207700','Ipumirim', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207759','Iraceminha', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207809','Irani', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207858','Irati', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4207908','Irine?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208005','It?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208104','Itai?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208203','Itaja?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208302','Itapema', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208401','Itapiranga', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208450','Itapo?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208500','Ituporanga', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208609','Jabor?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208708','Jacinto Machado', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208807','Jaguaruna', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208906','Jaragu? do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4208955','Jardin?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209003','Joa?aba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209102','Joinville', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209151','Jos? Boiteux', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209177','Jupi?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209201','Lacerd?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209300','Lages', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209409','Laguna', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209458','Lajeado Grande', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209508','Laurentino', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209607','Lauro Muller', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209706','Lebon R?gis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209805','Leoberto Leal', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209854','Lind?ia do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4209904','Lontras', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210001','Luiz Alves', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210035','Luzerna', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210050','Macieira', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210100','Mafra', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210209','Major Gercino', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210308','Major Vieira', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210407','Maracaj?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210506','Maravilha', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210555','Marema', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210605','Massaranduba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210704','Matos Costa', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210803','Meleiro', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210852','Mirim Doce', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4210902','Modelo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211009','Monda?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211058','Monte Carlo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211108','Monte Castelo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211207','Morro da Fuma?a', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211256','Morro Grande', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211306','Navegantes', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211405','Nova Erechim', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211454','Nova Itaberaba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211504','Nova Trento', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211603','Nova Veneza', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211652','Novo Horizonte', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211702','Orleans', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211751','Otac?lio Costa', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211801','Ouro', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211850','Ouro Verde', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211876','Paial', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211892','Painel', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4211900','Palho?a', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212007','Palma Sola', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212056','Palmeira', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212106','Palmitos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212205','Papanduva', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212239','Para?so', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212254','Passo de Torres', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212270','Passos Maia', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212304','Paulo Lopes', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212403','Pedras Grandes', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212502','Penha', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212601','Peritiba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212650','Pescaria Brava', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212700','Petrol?ndia', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212809','Balne?rio Pi?arras', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4212908','Pinhalzinho', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213005','Pinheiro Preto', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213104','Piratuba', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213153','Planalto Alegre', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213203','Pomerode', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213302','Ponte Alta', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213351','Ponte Alta do Norte', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213401','Ponte Serrada', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213500','Porto Belo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213609','Porto Uni?o', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213708','Pouso Redondo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213807','Praia Grande', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4213906','Presidente Castello Branco', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214003','Presidente Get?lio', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214102','Presidente Nereu', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214151','Princesa', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214201','Quilombo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214300','Rancho Queimado', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214409','Rio das Antas', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214508','Rio do Campo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214607','Rio do Oeste', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214706','Rio dos Cedros', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214805','Rio do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4214904','Rio Fortuna', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215000','Rio Negrinho', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215059','Rio Rcod_estino', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215075','Riqueza', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215109','Rodeio', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215208','Romel?ndia', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215307','Salete', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215356','Saltinho', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215406','Salto Veloso', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215455','Sang?o', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215505','Santa Cec?lia', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215554','Santa Helena', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215604','Santa Rosa de Lima', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215653','Santa Rosa do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215679','Santa Terezinha', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215687','Santa Terezinha do Progresso', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215695','Santiago do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215703','Santo Amaro da Imperatriz', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215752','S?o Bernardino', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215802','S?o Bento do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4215901','S?o Bonif?cio', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216008','S?o Carlos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216057','S?o Cristov?o do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216107','S?o Domingos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216206','S?o Francisco do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216255','S?o Jo?o do Oeste', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216305','S?o Jo?o Batista', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216354','S?o Jo?o do Itaperi?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216404','S?o Jo?o do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216503','S?o Joaquim', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216602','S?o Jos?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216701','S?o Jos? do Cedro', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216800','S?o Jos? do Cerrito', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4216909','S?o Louren?o do Oeste', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217006','S?o Ludgero', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217105','S?o Martinho', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217154','S?o Miguel da Boa Vista', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217204','S?o Miguel do Oeste', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217253','S?o Pedro de Alc?ntara', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217303','Saudades', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217402','Schroeder', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217501','Seara', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217550','Serra Alta', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217600','Sider?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217709','Sombrio', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217758','Sul Brasil', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217808','Tai?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217907','Tangar?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4217956','Tigrinhos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218004','Tijucas', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218103','Timb? do Sul', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218202','Timb?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218251','Timb? Grande', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218301','Tr?s Barras', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218350','Treviso', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218400','Treze de Maio', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218509','Treze T?lias', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218608','Trombudo Central', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218707','Tubar?o', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218756','Tun?polis', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218806','Turvo', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218855','Uni?o do Oeste', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218905','Urubici', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4218954','Urupema', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219002','Urussanga', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219101','Varge?o', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219150','Vargem', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219176','Vargem Bonita', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219200','Vidal Ramos', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219309','Videira', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219358','Vitor Meireles', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219408','Witmarsum', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219507','Xanxer?', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219606','Xavantina', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219705','Xaxim', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4219853','Zort?a', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4220000','Balne?rio Rinc?o', 42);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300034','Acegu?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300059','?gua Santa', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300109','Agudo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300208','Ajuricaba', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300307','Alecrim', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300406','Alegrete', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300455','Alegria', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300471','Almirante Tamandar? do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300505','Alpestre', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300554','Alto Alegre', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300570','Alto Feliz', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300604','Alvorada', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300638','Amaral Ferrador', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300646','Ametista do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300661','Andr? da Rocha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300703','Anta Gorda', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300802','Ant?nio Prado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300851','Arambar?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300877','Araric?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4300901','Aratiba', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301008','Arroio do Meio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301057','Arroio do Sal', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301073','Arroio do Padre', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301107','Arroio dos Ratos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301206','Arroio do Tigre', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301305','Arroio Grande', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301404','Arvorezinha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301503','Augusto Pestana', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301552','?urea', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301602','Bag?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301636','Balne?rio Pinhal', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301651','Bar?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301701','Bar?o de Cotegipe', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301750','Bar?o do Triunfo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301800','Barrac?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301859','Barra do Guarita', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301875','Barra do Quara?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301909','Barra do Ribeiro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301925','Barra do Rio Azul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4301958','Barra Funda', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302006','Barros Cassal', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302055','Benjamin Constant do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302105','Bento Gon?alves', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302154','Boa Vista das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302204','Boa Vista do Buric?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302220','Boa Vista do Cadeado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302238','Boa Vista do Incra', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302253','Boa Vista do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302303','Bom Jesus', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302352','Bom Princ?pio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302378','Bom Progresso', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302402','Bom Retiro do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302451','Boqueir?o do Le?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302501','Bossoroca', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302584','Bozano', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302600','Braga', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302659','Brochier', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302709','Buti?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302808','Ca?apava do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4302907','Cacequi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303004','Cachoeira do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303103','Cachoeirinha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303202','Cacique Doble', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303301','Caibat?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303400','Cai?ara', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303509','Camaqu?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303558','Camargo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303608','Cambar? do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303673','Campestre da Serra', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303707','Campina das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303806','Campinas do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4303905','Campo Bom', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304002','Campo Novo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304101','Campos Borges', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304200','Candel?ria', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304309','C?ndido God?i', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304358','Candiota', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304408','Canela', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304507','Cangu?u', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304606','Canoas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304614','Canudos do Vale', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304622','Cap?o Bonito do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304630','Cap?o da Canoa', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304655','Cap?o do Cip?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304663','Cap?o do Le?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304671','Capivari do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304689','Capela de Santana', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304697','Capit?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304705','Carazinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304713','Cara?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304804','Carlos Barbosa', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304853','Carlos Gomes', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304903','Casca', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4304952','Caseiros', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305009','Catu?pe', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305108','Caxias do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305116','Centen?rio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305124','Cerrito', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305132','Cerro Branco', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305157','Cerro Grande', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305173','Cerro Grande do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305207','Cerro Largo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305306','Chapada', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305355','Charqueadas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305371','Charrua', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305405','Chiapetta', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305439','Chu?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305447','Chuvisca', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305454','Cidreira', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305504','Cir?aco', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305587','Colinas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305603','Colorado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305702','Condor', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305801','Constantina', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305835','Coqueiro Baixo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305850','Coqueiros do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305871','Coronel Barros', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305900','Coronel Bicaco', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305934','Coronel Pilar', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305959','Cotipor?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4305975','Coxilha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306007','Crissiumal', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306056','Cristal', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306072','Cristal do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306106','Cruz Alta', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306130','Cruzaltense', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306205','Cruzeiro do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306304','David Canabarro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306320','Derrubadas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306353','Dezesseis de Novembro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306379','Dilermando de Aguiar', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306403','Dois Irm?os', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306429','Dois Irm?os das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306452','Dois Lajeados', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306502','Dom Feliciano', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306551','Dom Pedro de Alc?ntara', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306601','Dom Pedrito', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306700','Dona Francisca', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306734','Doutor Maur?cio Cardoso', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306759','Doutor Ricardo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306767','Eldorado do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306809','Encantado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306908','Encruzilhada do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306924','Engenho Velho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306932','Entre-Iju?s', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306957','Entre Rios do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4306973','Erebango', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307005','Erechim', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307054','Ernestina', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307104','Herval', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307203','Erval Grande', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307302','Erval Seco', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307401','Esmeralda', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307450','Esperan?a do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307500','Espumoso', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307559','Esta??o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307609','Est?ncia Velha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307708','Esteio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307807','Estrela', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307815','Estrela Velha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307831','Eug?nio de Castro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307864','Fagundes Varela', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4307906','Farroupilha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308003','Faxinal do Soturno', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308052','Faxinalzinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308078','Fazenda Vilanova', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308102','Feliz', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308201','Flores da Cunha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308250','Floriano Peixoto', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308300','Fontoura Xavier', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308409','Formigueiro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308433','Forquetinha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308458','Fortaleza dos Valos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308508','Frederico Westphalen', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308607','Garibaldi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308656','Garruchos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308706','Gaurama', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308805','General C?mara', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308854','Gentil', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4308904','Get?lio Vargas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309001','Giru?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309050','Glorinha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309100','Gramado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309126','Gramado dos Loureiros', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309159','Gramado Xavier', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309209','Gravata?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309258','Guabiju', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309308','Gua?ba', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309407','Guapor?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309506','Guarani das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309555','Harmonia', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309571','Herveiras', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309605','Horizontina', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309654','Hulha Negra', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309704','Humait?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309753','Ibarama', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309803','Ibia??', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309902','Ibiraiaras', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4309951','Ibirapuit?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310009','Ibirub?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310108','Igrejinha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310207','Iju?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310306','Il?polis', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310330','Imb?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310363','Imigrante', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310405','Independ?ncia', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310413','Inhacor?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310439','Ip?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310462','Ipiranga do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310504','Ira?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310538','Itaara', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310553','Itacurubi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310579','Itapuca', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310603','Itaqui', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310652','Itati', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310702','Itatiba do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310751','Ivor?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310801','Ivoti', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310850','Jaboticaba', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310876','Jacuizinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4310900','Jacutinga', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311007','Jaguar?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311106','Jaguari', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311122','Jaquirana', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311130','Jari', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311155','J?ia', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311205','J?lio de Castilhos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311239','Lagoa Bonita do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311254','Lago?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311270','Lagoa dos Tr?s Cantos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311304','Lagoa Vermelha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311403','Lajeado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311429','Lajeado do Bugre', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311502','Lavras do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311601','Liberato Salzano', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311627','Lindolfo Collor', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311643','Linha Nova', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311700','Machadinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311718','Ma?ambar?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311734','Mampituba', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311759','Manoel Viana', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311775','Maquin?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311791','Marat?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311809','Marau', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311908','Marcelino Ramos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4311981','Mariana Pimentel', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312005','Mariano Moro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312054','Marques de Souza', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312104','Mata', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312138','Mato Castelhano', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312153','Mato Leit?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312179','Mato Queimado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312203','Maximiliano de Almeida', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312252','Minas do Le?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312302','Miragua?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312351','Montauri', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312377','Monte Alegre dos Campos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312385','Monte Belo do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312401','Montenegro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312427','Morma?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312443','Morrinhos do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312450','Morro Redondo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312476','Morro Reuter', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312500','Mostardas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312609','Mu?um', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312617','Muitos Cap?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312625','Muliterno', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312658','N?o-Me-Toque', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312674','Nicolau Vergueiro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312708','Nonoai', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312757','Nova Alvorada', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312807','Nova Ara??', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312906','Nova Bassano', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4312955','Nova Boa Vista', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313003','Nova Br?scia', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313011','Nova Candel?ria', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313037','Nova Esperan?a do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313060','Nova Hartz', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313086','Nova P?dua', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313102','Nova Palma', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313201','Nova Petr?polis', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313300','Nova Prata', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313334','Nova Ramada', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313359','Nova Roma do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313375','Nova Santa Rita', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313391','Novo Cabrais', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313409','Novo Hamburgo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313425','Novo Machado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313441','Novo Tiradentes', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313466','Novo Xingu', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313490','Novo Barreiro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313508','Os?rio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313607','Paim Filho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313656','Palmares do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313706','Palmeira das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313805','Palmitinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313904','Panambi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4313953','Pantano Grande', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314001','Para?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314027','Para?so do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314035','Pareci Novo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314050','Parob?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314068','Passa Sete', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314076','Passo do Sobrado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314100','Passo Fundo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314134','Paulo Bento', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314159','Paverama', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314175','Pedras Altas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314209','Pedro Os?rio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314308','Peju?ara', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314407','Pelotas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314423','Picada Caf?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314456','Pinhal', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314464','Pinhal da Serra', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314472','Pinhal Grande', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314498','Pinheirinho do Vale', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314506','Pinheiro Machado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314548','Pinto Bandeira', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314555','Pirap?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314605','Piratini', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314704','Planalto', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314753','Po?o das Antas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314779','Pont?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314787','Ponte Preta', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314803','Port?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4314902','Porto Alegre', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315008','Porto Lucena', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315057','Porto Mau?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315073','Porto Vera Cruz', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315107','Porto Xavier', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315131','Pouso Novo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315149','Presidente Lucena', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315156','Progresso', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315172','Prot?sio Alves', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315206','Putinga', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315305','Quara?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315313','Quatro Irm?os', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315321','Quevedos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315354','Quinze de Novembro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315404','Redentora', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315453','Relvado', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315503','Restinga Seca', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315552','Rio dos ?ndios', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315602','Rio Grande', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315701','Rio Pardo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315750','Riozinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315800','Roca Sales', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315909','Rodeio Bonito', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4315958','Rolador', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316006','Rolante', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316105','Ronda Alta', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316204','Rondinha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316303','Roque Gonzales', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316402','Ros?rio do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316428','Sagrada Fam?lia', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316436','Saldanha Marinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316451','Salto do Jacu?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316477','Salvador das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316501','Salvador do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316600','Sananduva', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316709','Santa B?rbara do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316733','Santa Cec?lia do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316758','Santa Clara do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316808','Santa Cruz do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316907','Santa Maria', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316956','Santa Maria do Herval', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4316972','Santa Margarida do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317004','Santana da Boa Vista', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317103','Sant''Ana do Livramento', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317202','Santa Rosa', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317251','Santa Tereza', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317301','Santa Vit?ria do Palmar', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317400','Santiago', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317509','Santo ?ngelo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317558','Santo Ant?nio do Palma', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317608','Santo Ant?nio da Patrulha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317707','Santo Ant?nio das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317756','Santo Ant?nio do Planalto', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317806','Santo Augusto', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317905','Santo Cristo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4317954','Santo Expedito do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318002','S?o Borja', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318051','S?o Domingos do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318101','S?o Francisco de Assis', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318200','S?o Francisco de Paula', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318309','S?o Gabriel', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318408','S?o Jer?nimo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318424','S?o Jo?o da Urtiga', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318432','S?o Jo?o do Pol?sine', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318440','S?o Jorge', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318457','S?o Jos? das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318465','S?o Jos? do Herval', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318481','S?o Jos? do Hort?ncio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318499','S?o Jos? do Inhacor?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318507','S?o Jos? do Norte', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318606','S?o Jos? do Ouro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318614','S?o Jos? do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318622','S?o Jos? dos Ausentes', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318705','S?o Leopoldo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318804','S?o Louren?o do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4318903','S?o Luiz Gonzaga', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319000','S?o Marcos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319109','S?o Martinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319125','S?o Martinho da Serra', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319158','S?o Miguel das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319208','S?o Nicolau', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319307','S?o Paulo das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319356','S?o Pedro da Serra', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319364','S?o Pedro das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319372','S?o Pedro do Buti?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319406','S?o Pedro do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319505','S?o Sebasti?o do Ca?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319604','S?o Sep?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319703','S?o Valentim', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319711','S?o Valentim do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319737','S?o Val?rio do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319752','S?o Vendelino', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319802','S?o Vicente do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4319901','Sapiranga', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320008','Sapucaia do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320107','Sarandi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320206','Seberi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320230','Sede Nova', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320263','Segredo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320305','Selbach', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320321','Senador Salgado Filho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320354','Sentinela do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320404','Serafina Corr?a', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320453','S?rio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320503','Sert?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320552','Sert?o Santana', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320578','Sete de Setembro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320602','Severiano de Almeida', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320651','Silveira Martins', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320677','Sinimbu', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320701','Sobradinho', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320800','Soledade', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320859','Taba?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4320909','Tapejara', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321006','Tapera', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321105','Tapes', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321204','Taquara', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321303','Taquari', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321329','Taquaru?u do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321352','Tavares', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321402','Tenente Portela', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321436','Terra de Areia', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321451','Teut?nia', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321469','Tio Hugo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321477','Tiradentes do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321493','Toropi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321501','Torres', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321600','Tramanda?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321626','Travesseiro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321634','Tr?s Arroios', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321667','Tr?s Cachoeiras', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321709','Tr?s Coroas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321808','Tr?s de Maio', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321832','Tr?s Forquilhas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321857','Tr?s Palmeiras', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321907','Tr?s Passos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4321956','Trindade do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322004','Triunfo', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322103','Tucunduva', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322152','Tunas', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322186','Tupanci do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322202','Tupanciret?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322251','Tupandi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322301','Tuparendi', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322327','Turu?u', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322343','Ubiretama', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322350','Uni?o da Serra', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322376','Unistalda', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322400','Uruguaiana', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322509','Vacaria', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322525','Vale Verde', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322533','Vale do Sol', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322541','Vale Real', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322558','Vanini', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322608','Ven?ncio Aires', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322707','Vera Cruz', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322806','Veran?polis', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322855','Vespasiano Correa', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4322905','Viadutos', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323002','Viam?o', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323101','Vicente Dutra', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323200','Victor Graeff', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323309','Vila Flores', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323358','Vila L?ngaro', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323408','Vila Maria', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323457','Vila Nova do Sul', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323507','Vista Alegre', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323606','Vista Alegre do Prata', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323705','Vista Ga?cha', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323754','Vit?ria das Miss?es', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323770','Westfalia', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('4323804','Xangri-l?', 43);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5000203','?gua Clara', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5000252','Alcin?polis', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5000609','Amambai', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5000708','Anast?cio', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5000807','Anauril?ndia', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5000856','Ang?lica', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5000906','Ant?nio Jo?o', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5001003','Aparecida do Taboado', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5001102','Aquidauana', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5001243','Aral Moreira', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5001508','Bandeirantes', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5001904','Bataguassu', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002001','Bataypor?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002100','Bela Vista', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002159','Bodoquena', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002209','Bonito', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002308','Brasil?ndia', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002407','Caarap?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002605','Camapu?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002704','Campo Grande', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002803','Caracol', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002902','Cassil?ndia', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5002951','Chapad?o do Sul', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003108','Corguinho', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003157','Coronel Sapucaia', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003207','Corumb?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003256','Costa Rica', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003306','Coxim', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003454','Deod?polis', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003488','Dois Irm?os do Buriti', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003504','Douradina', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003702','Dourados', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003751','Eldorado', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003801','F?tima do Sul', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5003900','Figueir?o', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004007','Gl?ria de Dourados', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004106','Guia Lopes da Laguna', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004304','Iguatemi', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004403','Inoc?ncia', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004502','Itapor?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004601','Itaquira?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004700','Ivinhema', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004809','Japor?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5004908','Jaraguari', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005004','Jardim', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005103','Jate?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005152','Juti', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005202','Lad?rio', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005251','Laguna Carap?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005400','Maracaju', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005608','Miranda', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005681','Mundo Novo', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005707','Navira?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5005806','Nioaque', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006002','Nova Alvorada do Sul', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006200','Nova Andradina', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006259','Novo Horizonte do Sul', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006275','Para?so das ?guas', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006309','Parana?ba', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006358','Paranhos', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006408','Pedro Gomes', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006606','Ponta Por?', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5006903','Porto Murtinho', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007109','Ribas do Rio Pardo', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007208','Rio Brilhante', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007307','Rio Negro', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007406','Rio Verde de Mato Grosso', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007505','Rochedo', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007554','Santa Rita do Pardo', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007695','S?o Gabriel do Oeste', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007703','Sete Quedas', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007802','Selv?ria', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007901','Sidrol?ndia', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007935','Sonora', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007950','Tacuru', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5007976','Taquarussu', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5008008','Terenos', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5008305','Tr?s Lagoas', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5008404','Vicentina', 50);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100102','Acorizal', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100201','?gua Boa', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100250','Alta Floresta', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100300','Alto Araguaia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100359','Alto Boa Vista', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100409','Alto Gar?as', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100508','Alto Paraguai', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100607','Alto Taquari', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5100805','Apiac?s', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101001','Araguaiana', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101209','Araguainha', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101258','Araputanga', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101308','Aren?polis', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101407','Aripuan?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101605','Bar?o de Melga?o', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101704','Barra do Bugres', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101803','Barra do Gar?as', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101852','Bom Jesus do Araguaia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5101902','Brasnorte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102504','C?ceres', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102603','Campin?polis', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102637','Campo Novo do Parecis', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102678','Campo Verde', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102686','Campos de J?lio', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102694','Canabrava do Norte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102702','Canarana', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102793','Carlinda', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5102850','Castanheira', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103007','Chapada dos Guimar?es', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103056','Cl?udia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103106','Cocalinho', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103205','Col?der', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103254','Colniza', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103304','Comodoro', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103353','Confresa', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103361','Conquista D''Oeste', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103379','Cotrigua?u', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103403','Cuiab?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103437','Curvel?ndia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103452','Denise', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103502','Diamantino', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103601','Dom Aquino', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103700','Feliz Natal', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103809','Figueir?polis D''Oeste', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103858','Ga?cha do Norte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103908','General Carneiro', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5103957','Gl?ria D''Oeste', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104104','Guarant? do Norte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104203','Guiratinga', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104500','Indiava?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104526','Ipiranga do Norte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104542','Itanhang?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104559','Ita?ba', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104609','Itiquira', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104807','Jaciara', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5104906','Jangada', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105002','Jauru', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105101','Juara', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105150','Ju?na', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105176','Juruena', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105200','Juscimeira', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105234','Lambari D''Oeste', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105259','Lucas do Rio Verde', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105309','Luciara', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105507','Vila Bela da Sant?ssima Trindade', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105580','Marcel?ndia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105606','Matup?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105622','Mirassol D''Oeste', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5105903','Nobres', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106000','Nortel?ndia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106109','Nossa Senhora do Livramento', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106158','Nova Bandeirantes', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106174','Nova Nazar?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106182','Nova Lacerda', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106190','Nova Santa Helena', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106208','Nova Brasil?ndia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106216','Nova Cana? do Norte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106224','Nova Mutum', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106232','Nova Ol?mpia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106240','Nova Ubirat?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106257','Nova Xavantina', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106265','Novo Mundo', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106273','Novo Horizonte do Norte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106281','Novo S?o Joaquim', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106299','Parana?ta', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106307','Paranatinga', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106315','Novo Santo Ant?nio', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106372','Pedra Preta', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106422','Peixoto de Azevedo', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106455','Planalto da Serra', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106505','Pocon?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106653','Pontal do Araguaia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106703','Ponte Branca', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106752','Pontes e Lacerda', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106778','Porto Alegre do Norte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106802','Porto dos Ga?chos', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106828','Porto Esperidi?o', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5106851','Porto Estrela', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107008','Poxor?o', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107040','Primavera do Leste', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107065','Quer?ncia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107107','S?o Jos? dos Quatro Marcos', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107156','Reserva do Caba?al', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107180','Ribeir?o Cascalheira', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107198','Ribeir?ozinho', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107206','Rio Branco', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107248','Santa Carmem', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107263','Santo Afonso', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107297','S?o Jos? do Povo', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107305','S?o Jos? do Rio Claro', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107354','S?o Jos? do Xingu', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107404','S?o Pedro da Cipa', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107578','Rondol?ndia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107602','Rondon?polis', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107701','Ros?rio Oeste', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107743','Santa Cruz do Xingu', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107750','Salto do C?u', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107768','Santa Rita do Trivelato', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107776','Santa Terezinha', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107792','Santo Ant?nio do Leste', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107800','Santo Ant?nio do Leverger', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107859','S?o F?lix do Araguaia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107875','Sapezal', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107883','Serra Nova Dourada', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107909','Sinop', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107925','Sorriso', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107941','Tabapor?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5107958','Tangar? da Serra', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108006','Tapurah', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108055','Terra Nova do Norte', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108105','Tesouro', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108204','Torixor?u', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108303','Uni?o do Sul', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108352','Vale de S?o Domingos', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108402','V?rzea Grande', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108501','Vera', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108600','Vila Rica', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108808','Nova Guarita', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108857','Nova Maril?ndia', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108907','Nova Maring?', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5108956','Nova Monte Verde', 51);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200050','Abadia de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200100','Abadi?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200134','Acre?na', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200159','Adel?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200175','?gua Fria de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200209','?gua Limpa', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200258','?guas Lindas de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200308','Alex?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200506','Alo?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200555','Alto Horizonte', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200605','Alto Para?so de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200803','Alvorada do Norte', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200829','Amaralina', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200852','Americano do Brasil', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5200902','Amorin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201108','An?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201207','Anhanguera', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201306','Anicuns', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201405','Aparecida de Goi?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201454','Aparecida do Rio Doce', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201504','Apor?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201603','Ara?u', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201702','Aragar?as', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5201801','Aragoi?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5202155','Araguapaz', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5202353','Aren?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5202502','Aruan?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5202601','Auril?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5202809','Avelin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203104','Baliza', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203203','Barro Alto', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203302','Bela Vista de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203401','Bom Jardim de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203500','Bom Jesus de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203559','Bonfin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203575','Bon?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203609','Brazabrantes', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203807','Brit?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203906','Buriti Alegre', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203939','Buriti de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5203962','Buritin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204003','Cabeceiras', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204102','Cachoeira Alta', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204201','Cachoeira de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204250','Cachoeira Dourada', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204300','Ca?u', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204409','Caiap?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204508','Caldas Novas', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204557','Caldazinha', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204607','Campestre de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204656','Campina?u', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204706','Campinorte', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204805','Campo Alegre de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204854','Campo Limpo de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204904','Campos Belos', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5204953','Campos Verdes', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205000','Carmo do Rio Verde', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205059','Castel?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205109','Catal?o', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205208','Catura?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205307','Cavalcante', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205406','Ceres', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205455','Cezarina', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205471','Chapad?o do C?u', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205497','Cidade Ocidental', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205513','Cocalzinho de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205521','Colinas do Sul', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205703','C?rrego do Ouro', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205802','Corumb? de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5205901','Corumba?ba', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5206206','Cristalina', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5206305','Cristian?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5206404','Crix?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5206503','Crom?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5206602','Cumari', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5206701','Damian?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5206800','Damol?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5206909','Davin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207105','Diorama', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207253','Doverl?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207352','Edealina', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207402','Ed?ia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207501','Estrela do Norte', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207535','Faina', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207600','Fazenda Nova', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207808','Firmin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5207907','Flores de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208004','Formosa', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208103','Formoso', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208152','Gameleira de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208301','Divin?polis de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208400','Goian?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208509','Goiandira', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208608','Goian?sia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208707','Goi?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208806','Goianira', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5208905','Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209101','Goiatuba', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209150','Gouvel?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209200','Guap?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209291','Guara?ta', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209408','Guarani de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209457','Guarinos', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209606','Heitora?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209705','Hidrol?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209804','Hidrolina', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209903','Iaciara', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209937','Inaciol?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5209952','Indiara', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210000','Inhumas', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210109','Ipameri', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210158','Ipiranga de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210208','Ipor?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210307','Israel?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210406','Itabera?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210562','Itaguari', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210604','Itaguaru', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210802','Itaj?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5210901','Itapaci', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211008','Itapirapu?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211206','Itapuranga', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211305','Itarum?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211404','Itau?u', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211503','Itumbiara', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211602','Ivol?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211701','Jandaia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211800','Jaragu?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5211909','Jata?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212006','Jaupaci', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212055','Jes?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212105','Jovi?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212204','Jussara', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212253','Lagoa Santa', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212303','Leopoldo de Bulh?es', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212501','Luzi?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212600','Mairipotaba', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212709','Mamba?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212808','Mara Rosa', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212907','Marzag?o', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5212956','Matrinch?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213004','Mauril?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213053','Mimoso de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213087','Mina?u', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213103','Mineiros', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213400','Moipor?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213509','Monte Alegre de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213707','Montes Claros de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213756','Montividiu', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213772','Montividiu do Norte', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213806','Morrinhos', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213855','Morro Agudo de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5213905','Moss?medes', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214002','Mozarl?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214051','Mundo Novo', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214101','Mutun?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214408','Naz?rio', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214507','Ner?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214606','Niquel?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214705','Nova Am?rica', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214804','Nova Aurora', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214838','Nova Crix?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214861','Nova Gl?ria', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214879','Nova Igua?u de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5214903','Nova Roma', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215009','Nova Veneza', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215207','Novo Brasil', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215231','Novo Gama', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215256','Novo Planalto', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215306','Orizona', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215405','Ouro Verde de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215504','Ouvidor', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215603','Padre Bernardo', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215652','Palestina de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215702','Palmeiras de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215801','Palmelo', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5215900','Palmin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5216007','Panam?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5216304','Paranaiguara', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5216403','Para?na', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5216452','Perol?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5216809','Petrolina de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5216908','Pilar de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5217104','Piracanjuba', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5217203','Piranhas', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5217302','Piren?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5217401','Pires do Rio', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5217609','Planaltina', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5217708','Pontalina', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218003','Porangatu', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218052','Porteir?o', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218102','Portel?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218300','Posse', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218391','Professor Jamil', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218508','Quirin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218607','Rialma', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218706','Rian?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218789','Rio Quente', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218805','Rio Verde', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5218904','Rubiataba', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219001','Sanclerl?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219100','Santa B?rbara de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219209','Santa Cruz de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219258','Santa F? de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219308','Santa Helena de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219357','Santa Isabel', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219407','Santa Rita do Araguaia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219456','Santa Rita do Novo Destino', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219506','Santa Rosa de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219605','Santa Tereza de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219704','Santa Terezinha de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219712','Santo Ant?nio da Barra', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219738','Santo Ant?nio de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219753','Santo Ant?nio do Descoberto', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219803','S?o Domingos', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5219902','S?o Francisco de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220009','S?o Jo?o D''Alian?a', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220058','S?o Jo?o da Para?na', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220108','S?o Lu?s de Montes Belos', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220157','S?o Lu?z do Norte', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220207','S?o Miguel do Araguaia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220264','S?o Miguel do Passa Quatro', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220280','S?o Patr?cio', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220405','S?o Sim?o', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220454','Senador Canedo', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220504','Serran?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220603','Silv?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220686','Simol?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5220702','S?tio D''Abadia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221007','Taquaral de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221080','Teresina de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221197','Terez?polis de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221304','Tr?s Ranchos', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221403','Trindade', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221452','Trombas', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221502','Turv?nia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221551','Turvel?ndia', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221577','Uirapuru', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221601','Urua?u', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221700','Uruana', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221809','Uruta?', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221858','Valpara?so de Goi?s', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5221908','Varj?o', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5222005','Vian?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5222054','Vicentin?polis', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5222203','Vila Boa', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5222302','Vila Prop?cio', 52);
Insert into cidade (cod_cid, nome_cid, cod_est) values ('5300108','Bras?lia', 53);


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

insert into usuario(cod_usu, email_usu,senha_usu,login_usu)
values
(48,'Sophia86145@email.com',91995,'Sophia861'),
(49,'Luiza28039@email.com',93490,'Luiza280'),
(50,'Helena25116@email.com',31496,'Helena251'),
(51,'Maria Eduarda65019@email.com',71021,'Maria Eduarda650'),
(52,'Maria Luiza27417@email.com',47710,'Maria Luiza274'),
(53,'Helo?sa1613@email.com',20513,'Helo?sa16'),
(54,'Mariana40836@email.com',35808,'Mariana408'),
(55,'Lara1552@email.com',55109,'Lara15'),
(56,'L?via94417@email.com',10846,'L?via944'),
(57,'Lorena32727@email.com',61302,'Lorena327'),
(58,'Rafaela60648@email.com',50309,'Rafaela606'),
(59,'Sarah70917@email.com',11453,'Sarah709'),
(60,'Melissa65150@email.com',99943,'Melissa651'),
(61,'Ana J?lia51529@email.com',99422,'Ana J?lia515'),
(62,'Emanuelly18323@email.com',90656,'Emanuelly183'),
(63,'Rebeca6435@email.com',12889,'Rebeca64'),
(64,'Vit?ria73921@email.com',93951,'Vit?ria739'),
(65,'Bianca85028@email.com',37940,'Bianca850'),
(66,'Larissa12219@email.com',16575,'Larissa122'),
(67,'Maria Fernanda71427@email.com',44115,'Maria Fernanda714'),
(68,'Amanda59633@email.com',16146,'Amanda596'),
(69,'Ana13346@email.com',49970,'Ana133'),
(70,'Sofia17117@email.com',7586,'Sofia171'),
(71,'Laura42531@email.com',76271,'Laura425'),
(72,'Luisa15821@email.com',80604,'Luisa158'),
(73,'Manuela22754@email.com',32916,'Manuela227'),
(74,'Isis41522@email.com',38853,'Isis415'),
(75,'Isadora22134@email.com',7436,'Isadora221'),
(76,'Gabriela73034@email.com',16340,'Gabriela730'),
(77,'Elisa66913@email.com',79502,'Elisa669'),
(78,'Pietra54328@email.com',78347,'Pietra543'),
(79,'B?rbara75742@email.com',78098,'B?rbara757'),
(80,'Larissa21449@email.com',39644,'Larissa214'),
(81,'Maria18117@email.com',87282,'Maria181'),
(82,'Nicole93552@email.com',7091,'Nicole935'),
(83,'Mariana13032@email.com',67860,'Mariana130'),
(84,'Ol?via57434@email.com',66330,'Ol?via574'),
(85,'Aline94718@email.com',41072,'Aline947'),
(86,'Ma?sa21023@email.com',54578,'Ma?sa210'),
(87,'Carolina1144@email.com',64801,'Carolina11'),
(88,'Anabela93455@email.com',11264,'Anabela934'),
(89,'Ariela40813@email.com',1433,'Ariela408'),
(90,'Iara98423@email.com',50494,'Iara984'),
(91,'Brenda2038@email.com',82216,'Brenda20'),
(92,'Analice35226@email.com',89698,'Analice352'),
(93,'Luana80455@email.com',78237,'Luana804'),
(94,'Marina41847@email.com',32147,'Marina418'),
(95,'Estela13726@email.com',38892,'Estela137'),
(96,'Lia64916@email.com',87592,'Lia649'),
(97,'Paloma33048@email.com',69035,'Paloma330'),
(98,'Juliana63612@email.com',23053,'Juliana636'),
(99,'Karen28130@email.com',59442,'Karen281'),
(100,'Sabrina73747@email.com',40426,'Sabrina737'),
(101,'Belinda22743@email.com',34027,'Belinda227'),
(102,'Carol77340@email.com',81798,'Carol773'),
(103,'Clarissa71244@email.com',73246,'Clarissa712'),
(104,'Milene13949@email.com',9796,'Milene139'),
(105,'Alessandra76645@email.com',73547,'Alessandra766'),
(106,'Dulce11646@email.com',96835,'Dulce116'),
(107,'Miguel17138@email.com',72138,'Miguel171'),
(108,'Matheus67712@email.com',76189,'Matheus677'),
(109,'Lorenzo38515@email.com',28240,'Lorenzo385'),
(110,'Felipe57018@email.com',13204,'Felipe570'),
(111,'Gustavo84822@email.com',87074,'Gustavo848'),
(112,'Leonardo19947@email.com',17148,'Leonardo199'),
(113,'Benjamin12824@email.com',19462,'Benjamin128'),
(114,'Isaac61647@email.com',98237,'Isaac616'),
(115,'Lucca21855@email.com',57871,'Lucca218'),
(116,'Cau?52818@email.com',9038,'Cau?528'),
(117,'Bryan54824@email.com',15540,'Bryan548'),
(118,'Jo?o Miguel47214@email.com',69496,'Jo?o Miguel472'),
(119,'Vicente61740@email.com',88592,'Vicente617'),
(120,'Ant?nio92526@email.com',72732,'Ant?nio925'),
(121,'Ben?cio33520@email.com',85367,'Ben?cio335'),
(122,'Davi Lucca46546@email.com',96720,'Davi Lucca465'),
(123,'Thiago90822@email.com',4650,'Thiago908'),
(124,'Bernardo24616@email.com',78887,'Bernardo246'),
(125,'Heitor851@email.com',19469,'Heitor8'),
(126,'Guilherme92553@email.com',79604,'Guilherme925'),
(127,'Rafael84048@email.com',61488,'Rafael840'),
(128,'Felipe90718@email.com',19359,'Felipe907'),
(129,'Daniel23229@email.com',10065,'Daniel232'),
(130,'Jo?o95538@email.com',10688,'Jo?o955'),
(131,'Leonardo7436@email.com',32237,'Leonardo74'),
(132,'Andr?11913@email.com',7660,'Andr?119'),
(133,'Levi20731@email.com',97346,'Levi207'),
(134,'Vicente18823@email.com',65903,'Vicente188'),
(135,'Alexandre88033@email.com',88469,'Alexandre880'),
(136,'Rodrigo76322@email.com',87283,'Rodrigo763'),
(137,'Valentim89223@email.com',48135,'Valentim892'),
(138,'Jonathan21926@email.com',18433,'Jonathan219'),
(139,'?ngelo48735@email.com',75484,'?ngelo487'),
(140,'Ricardo25213@email.com',90268,'Ricardo252'),
(141,'J?lio14243@email.com',64025,'J?lio142'),
(142,'Aquiles16745@email.com',8111,'Aquiles167'),
(143,'Raul28723@email.com',13537,'Raul287'),
(144,'C?sar19131@email.com',30572,'C?sar191'),
(145,'Alexander33732@email.com',56418,'Alexander337'),
(146,'Renato10316@email.com',24095,'Renato103'),
(147,'Caetano33826@email.com',47743,'Caetano338');


insert into paciente(cod_pac,nome_pac,alt_pac,peso_pac,data_nasc_pac,gen_pac,cod_usu,cod_status)
values
(1,'Pedro Juliano',1.76,78.20,'2002-6-1','M',1,1),
(2,'João Paulo',1.75,75.20,'1990-5-13','M',2,1),
(3,'Gabriel',1.89,89.3,'1996-4-11','M',3,2),
(4,'Victor',1.79,79.9,'2001-2-20','M',4,2),
(5,'Sabrina',1.75,65.2,'1997-5-6','F',5,2),
(6,'Angela',1.73,64,'2000-5-4','F',6,2),
(7,'Gabriela',1.68,59.3,'1997-8-9','F',7,2),
(8,'Benedito',1.79,70.5,'1990-5-15','M',8,2),
(9,'Bernardo',1.71,100.3,'1990-3-27','M',9,2),
(10,'Julia',1.80,76.2,'2000-4-27','F',10,2),
(11,'Silvia',1.69,81.1,'1990-3-9','F',11,2),
(12,'Lucas',1.82,85.3,'1991-2-10','M',12,2),
(13,'Marcos',1.78,81.2,'1992-7-12','M',13,1),
(14,'Julio',1.80,84.5,'1993-11-1','M',14,1),
(15,'Marcos',1.76,79,'1993-6-15','M',15,2),
(16,'Maria',1.64,58.9,'1999-5-19','F',16,2),
(17,'Miriam',1.71,75.20,'1990-7-13','F',17,3),
(18,'Carla',1.79,81.1,'1994-9-26','F',18,3),
(19,'Sabrina',1.64,70.5,'1999-7-7','F',19,3),
(20,'Gilberto',1.82,89.3,'1990-10-20','M',20,3),
(21,'Marcelo',1.78,86.30,'1996-11-19','M',21,3),
(22,'Juliano',1.81,89.6,'1992-4-28','M',22,3),
(23,'Sandro',1.76,79.5,'1996-7-1','M',23,3),
(24,'Beto',1.69,69,'1992-2-13','M',24,3),
(25,'Sandra',1.79,82,'1998-2-21','M',25,3),
(26,'Vinicius',1.79,86.30,'1993-7-18','M',26,3),
(27,'Giuliano',1.75,85.30,'1992-1-14','M',27,3),
(28,'Marcos',1.69,68,'1994-5-16','M',28,3),
(29,'Gilberto',1.64,70.5,'1993-1-13','M',29,2),
(30,'Sandro',1.81,89.8,'1994-6-9','M',30,2),
(31,'Juliano',1.79,79.5,'2001-8-15','M',31,1),
(32,'Sabrina',1.76,86.4,'2002-9-12','F',32,1),
(33,'Marcia',1.69,75.20,'1995-4-10','F',33,1),
(34,'Maria Clara',1.79,78.20,'1999-11-6','F',34,1),
(35,'Clara',1.69,68.3,'2002-3-17','F',35,1),
(36,'Erene',1.69,64,'1993-3-20','F',36,1),
(37,'Estefano',1.79,86.5,'1999-8-26','M',37,1),
(38,'Juliano',1.82,98.6,'1994-1-24','M',38,1),
(39,'Miguel',1.79,85.3,'1999-3-9','M',39,1),
(40,'Marcos',1.79,83,'1998-4-1','M',40,3),
(41,'Marcelo',1.72,72,'1997-8-7','M',41,3),
(42,'Silvia',1.79,74,'1996-3-3','F',42,3),
(43,'Angelica',1.59,52,'1995-10-15','F',43,1),
(44,'Maria Clara',1.71,71,'1998-4-12','F',44,1),
(45,'Amanda',1.68,63,'1994-3-7','F',45,1),
(46,'Gilvana',1.58,52.1,'1996-4-22','F',46,1),
(47,'Sandra',1.75,76.2,'1992-3-13','F',47,3);


insert into paciente(cod_pac,nome_pac,alt_pac,peso_pac,data_nasc_pac,gen_pac,cod_usu,cod_status)
values
(48,'Sophia',1.87,85.92,'1999-9-7','F',48,1),
(49,'Luiza',1.73,92.20,'1973-6-8','F',49,1),
(50,'Helena',1.85,94.9,'1989-3-4','F',50,1),
(51,'Maria Eduarda',1.53,75.28,'1998-8-12','F',51,1),
(52,'Maria Luiza',1.71,57.54,'1971-12-11','F',52,1),
(53,'Helo?sa',1.67,72.58,'1978-3-23','F',53,1),
(54,'Mariana',1.82,90.84,'1975-9-5','F',54,1),
(55,'Lara',1.77,93.31,'1996-9-8','F',55,1),
(56,'L?via',1.67,52.68,'1996-1-14','F',56,1),
(57,'Lorena',1.65,97.93,'1972-9-3','F',57,2),
(58,'Rafaela',1.52,94.61,'1992-9-22','F',58,2),
(59,'Sarah',1.52,56.54,'2004-12-14','F',59,2),
(60,'Melissa',1.68,67.58,'1997-11-15','F',60,2),
(61,'Ana J?lia',1.79,58.83,'1974-1-3','F',61,2),
(62,'Emanuelly',1.84,67.5,'2005-9-7','F',62,2),
(63,'Rebeca',1.63,56.27,'1987-3-16','F',63,3),
(64,'Vit?ria',1.73,72.19,'1974-3-11','F',64,3),
(65,'Bianca',1.84,56.44,'1990-4-26','F',65,3),
(66,'Larissa',1.83,86.55,'1975-11-14','F',66,3),
(67,'Maria Fernanda',1.81,77.64,'1980-1-23','F',67,3),
(68,'Amanda',1.84,94.89,'1979-2-3','F',68,3),
(69,'Ana',1.65,68.66,'2004-5-16','F',69,1),
(70,'Sofia',1.57,98.74,'1990-3-24','F',70,1),
(71,'Laura',1.77,68.95,'1971-3-16','F',71,1),
(72,'Luisa',1.74,59.38,'1993-3-2','F',72,1),
(73,'Manuela',1.86,96.9,'1970-6-5','F',73,1),
(74,'Isis',1.88,80.13,'1975-6-1','F',74,1),
(75,'Isadora',1.77,95.8,'1974-6-4','F',75,1),
(76,'Gabriela',1.63,61.43,'2002-4-11','F',76,1),
(77,'Elisa',1.52,57.84,'1995-12-24','F',77,1),
(78,'Pietra',1.63,94.89,'1970-4-28','F',78,1),
(79,'B?rbara',1.88,60.26,'2003-12-26','F',79,1),
(80,'Larissa',1.88,71.52,'1973-12-6','F',80,1),
(81,'Maria',1.58,74.63,'1997-8-4','F',81,1),
(82,'Nicole',1.78,68.89,'2003-9-13','F',82,2),
(83,'Mariana',1.75,74.58,'2004-6-21','F',83,2),
(84,'Ol?via',1.64,62.43,'1981-10-2','F',84,2),
(85,'Aline',1.85,81.60,'1970-7-14','F',85,2),
(86,'Ma?sa',1.66,59.60,'2002-2-26','F',86,2),
(87,'Carolina',1.83,82.3,'1976-2-4','F',87,2),
(88,'Anabela',1.74,54.92,'1999-9-23','F',88,2),
(89,'Ariela',1.74,56.32,'1987-2-5','F',89,1),
(90,'Iara',1.88,98.54,'2004-10-5','F',90,1),
(91,'Brenda',1.83,83.44,'1970-1-23','F',91,1),
(92,'Analice',1.61,71.64,'2004-4-10','F',92,2),
(93,'Luana',1.54,51.2,'1978-7-17','F',93,2),
(94,'Marina',1.58,64.10,'1984-3-23','F',94,2),
(95,'Estela',1.51,83.46,'1989-5-10','F',95,2),
(96,'Lia',1.84,99.99,'1975-2-5','F',96,2),
(97,'Paloma',1.65,58.34,'1978-5-9','F',97,2),
(98,'Juliana',1.51,91.90,'1989-7-22','F',98,2),
(99,'Karen',1.89,85.73,'1992-9-28','F',99,2),
(100,'Sabrina',1.82,54.68,'1994-4-21','F',100,2),
(101,'Belinda',1.71,75.89,'1980-4-22','F',101,2),
(102,'Carol',1.81,73.95,'1983-9-6','F',102,2),
(103,'Clarissa',1.70,66.89,'1995-10-17','F',103,1),
(104,'Milene',1.63,51.85,'1976-2-21','F',104,1),
(105,'Alessandra',1.65,81.28,'1985-3-3','F',105,1),
(106,'Dulce',1.66,66.86,'1994-12-8','F',106,1),
(107,'Miguel',1.63,52.39,'1975-11-4','M',107,1),
(108,'Matheus',1.62,52.94,'1983-12-13','M',108,1),
(109,'Lorenzo',1.87,52.49,'1987-9-21','M',109,1),
(110,'Felipe',1.86,53.11,'2004-10-3','M',110,3),
(111,'Gustavo',1.52,86.27,'1972-5-21','M',111,3),
(112,'Leonardo',1.64,89.94,'1992-12-23','M',112,3),
(113,'Benjamin',1.83,68.11,'1978-9-25','M',113,3),
(114,'Isaac',1.55,55.71,'1978-5-17','M',114,3),
(115,'Lucca',1.84,85.86,'1978-5-27','M',115,3),
(116,'Cau?',1.90,51.98,'2002-10-12','M',116,3),
(117,'Bryan',1.79,86.55,'1999-7-24','M',117,3),
(118,'Jo?o Miguel',1.64,50.72,'1990-2-20','M',118,3),
(119,'Vicente',1.55,60.27,'2002-11-22','M',119,3),
(120,'Ant?nio',1.51,61.54,'1991-4-24','M',120,3),
(121,'Ben?cio',1.70,89.78,'1998-9-16','M',121,2),
(122,'Davi Lucca',1.52,61.14,'1971-11-2','M',122,2),
(123,'Thiago',1.67,100.18,'1976-2-23','M',123,2),
(124,'Bernardo',1.86,60.32,'2003-11-2','M',124,2),
(125,'Heitor',1.57,78.90,'1996-3-23','M',125,1),
(126,'Guilherme',1.88,67.15,'1989-1-22','M',126,1),
(127,'Rafael',1.79,66.31,'1981-1-9','M',127,1),
(128,'Felipe',1.88,100.93,'1987-7-26','M',128,1),
(129,'Daniel',1.88,85.11,'1984-3-5','M',129,1),
(130,'Jo?o',1.77,77.86,'1985-5-6','M',130,1),
(131,'Leonardo',1.67,99.28,'1972-4-6','M',131,2),
(132,'Andr?',1.79,87.71,'1994-11-17','M',132,2),
(133,'Levi',1.77,84.83,'1980-9-13','M',133,2),
(134,'Vicente',1.87,52.78,'1973-9-12','M',134,2),
(135,'Alexandre',1.63,81.51,'1974-12-24','M',135,2),
(136,'Rodrigo',1.66,76.58,'2002-7-16','M',136,2),
(137,'Valentim',1.68,67.43,'1985-2-11','M',137,2),
(138,'Jonathan',1.80,79.35,'1989-7-11','M',138,2),
(139,'?ngelo',1.85,71.2,'1986-12-6','M',139,2),
(140,'Ricardo',1.58,54.7,'1974-10-24','M',140,2),
(141,'J?lio',1.73,88.11,'1999-5-21','M',141,2),
(142,'Aquiles',1.53,80.96,'1988-12-23','M',142,2),
(143,'Raul',1.75,68.29,'1983-4-2','M',143,3),
(144,'C?sar',1.63,88.71,'1978-7-21','M',144,3),
(145,'Alexander',1.74,64.49,'1980-2-6','M',145,1),
(146,'Renato',1.87,80.6,'1991-4-19','M',146,1),
(147,'Caetano',1.68,57.63,'1986-6-27','M',147,1);



insert into endereco(cod_end,rua_end,cep_end,num_end,comp_end,bai_end,cod_pac,cod_cid)
values 
(1,'Principal158',46695702,'29','Ap.967','centro',1,4216701),
(2,'Principal71',10379309,'1820','Ap.76','centro',2,4216701),
(3,'Principal161',52340269,'1453','Ap.527','centro',3,4216701),
(4,'Principal92',38819474,'997','Ap.511','centro',4,4216701),
(5,'Principal12',96383169,'959','Ap.233','centro',5,4216701),
(6,'Principal66',91841319,'1324','Ap.93','centro',6,4216701),
(7,'Principal80',13585516,'1188','Ap.998','Costeira',7,4217204),
(8,'Principal34',56455042,'451','Ap.381','Costeira',8,4217204),
(9,'Principal184',20271629,'978','Ap.682','Costeira',9,4217204),
(10,'Principal22',43776649,'866','Ap.925','centro',10,4217204),
(11,'Principal75',55524866,'1745','Ap.928','centro',11,4217204),
(12,'Principal162',32835989,'1049','Ap.326','centro',12,4217204),
(13,'Principal25',34311422,'688','Ap.435','centro',13,4217204),
(14,'Principal146',29128848,'271','Ap.272','centro',14,4204202),
(15,'Principal68',55905793,'440','Ap.22','centro',15,4204202),
(16,'segunda93',37853715,'263','Ap.476','centro',16,4204202),
(17,'segunda6',67901293,'1146','Ap.174','centro',17,4204202),
(18,'segunda188',15083910,'1639','Ap.406','centro',18,4204202),
(19,'segunda2',66416852,'1585','Ap.711','Meia Volta',19,4204202),
(20,'segunda81',24906881,'1740','Ap.288','Meia Volta',20,4204202),
(21,'segunda96',16787189,'320','Ap.287','Meia Volta',21,4204202),
(22,'segunda100',17048786,'1910','Ap.311','Meia Volta',22,4204202),
(23,'segunda15',95478911,'545','Ap.404','centro',23,4204202),
(24,'segunda119',90541494,'690','Ap.896','centro',24,4204202),
(25,'segunda141',82490531,'45','Ap.864','centro',25,4321402),
(26,'Fagundes130',17079493,'1533','Ap.950','Jardin',26,4321402),
(27,'Fagundes150',25244654,'815','Ap.408','Jardin',27,4321402),
(28,'Fagundes150',95316884,'91','Ap.367','Jardin',28,4321402),
(29,'Fagundes70',89233386,'1759','Ap.104','Jardin',29,4307005),
(30,'Fagundes74',90905540,'705','Ap.105','Jardin',30,4307005),
(31,'Fagundes190',61743693,'1638','Ap.183','Jardin',31,4307005),
(32,'Fagundes94',26968560,'1023','Ap.555','Jardin',32,4307005),
(33,'Fagundes48',37943550,'722','Ap.846','Jardin',33,4307005),
(34,'Fagundes44',24352827,'509','Ap.102','centro',34,4314902),
(35,'Fagundes142',89519300,'341','Ap.145','centro',35,4314902),
(36,'Fagundes171',15696202,'38','Ap.979','centro',36,4314902),
(37,'Fagundes177',11201655,'1328','Ap.279','centro',37,4314902),
(38,'Fagundes84',53350352,'778','Ap.486','Baruiri',38,4314902),
(39,'Euclides167',12340663,'757','Ap.941','Baruiri',39,4314902),
(40,'Euclides73',68377480,'481','Ap.262','Baruiri',40,4314902),
(41,'Euclides167',36885217,'1848','Ap.396','centro',41,4314902),
(42,'Euclides22',87228364,'33','Ap.282','centro',42,4314100),
(43,'Euclides49',35590318,'1415','Ap.915','centro',43,4314100),
(44,'Euclides8',17058422,'208','Ap.535','centro',44,4314100),
(45,'Euclides157',22997815,'1791','Ap.949','Tramontina',45,4314100),
(46,'Euclides169',29176396,'1607','Ap.534','Tramontina',46,4314100),
(47,'Euclides60',56122015,'1110','Ap.885','Tramontina',47,4314100);


/*endereco de mais users*/

insert into endereco(cod_end,rua_end,cep_end,num_end,comp_end,bai_end,cod_pac,cod_cid)
values 
(48,'Rua25',94827972,'2203','Ap.876','centro',48,3518800),
(49,'Rua832',88539214,'1396','Ap.653','centro',49,3518800),
(50,'Rua579',40560199,'3068','Ap.96','centro',50,3518800),
(51,'Rua173',47652755,'951','Ap.418','centro',51,3518800),
(52,'Rua89',83210690,'2923','Ap.6','centro',52,3518800),
(53,'Rua318',87162654,'539','Ap.249','centro',53,3534401),
(54,'Rua93',10701283,'1662','Ap.173','centro',54,3534401),
(55,'Rua606',91698455,'3243','Ap.570','centro',55,3534401),
(56,'Rua640',93373287,'794','Ap.90','centro',56,3534401),
(57,'Rua250',44088831,'3553','Ap.992','centro',57,3547809),
(58,'Rua618',45638564,'3321','Ap.277','centro',58,3547809),
(59,'Rua637',48654438,'311','Ap.501','Boa Viagem',59,3303302),
(60,'Rua747',56254401,'1915','Ap.657','Boa Viagem',60,3303302),
(61,'Rua805',80533404,'1319','Ap.921','Boa Viagem',61,3303302),
(62,'Rua579',22522295,'1630','Ap.982','Boa Viagem',62,3303302),
(63,'Rua915',92386844,'1060','Ap.456','Boa Viagem',63,3303302),
(64,'Rua10',48874997,'1498','Ap.901','Boa Viagem',64,3303500),
(65,'Rua59',33847293,'696','Ap.45','Boa Viagem',65,3303500),
(66,'Rua816',69017913,'3652','Ap.398','Boa Viagem',66,3303500),
(67,'Rua977',82069978,'829','Ap.449','Boa Viagem',67,3303500),
(68,'Rua784',74222471,'450','Ap.570','Boa Viagem',68,3303500),
(69,'Rua57',59890630,'3128','Ap.86','Boa Viagem',69,3300704),
(70,'Rua112',23680979,'1850','Ap.174','Boa Viagem',70,3300704),
(71,'Rua31',58110590,'2487','Ap.172','Boa Viagem',71,3300704),
(72,'Rua598',74046382,'2644','Ap.73','centro',72,3300704),
(73,'Rua236',59776482,'288','Ap.154','centro',73,3300704),
(74,'Rua448',70176817,'3826','Ap.656','centro',74,3300100),
(75,'Rua602',19320037,'2099','Ap.309','centro',75,3300100),
(76,'Rua925',34408560,'3280','Ap.205','centro',76,3300100),
(77,'Rua128',29137115,'387','Ap.321','centro',77,3300100),
(78,'Rua214',31515803,'3519','Ap.87','centro',78,5100102),
(79,'Principal621',58406199,'1837','Ap.543','centro',79,5100102),
(80,'Principal908',38156608,'411','Ap.588','centro',80,5100102),
(81,'Principal415',71433983,'308','Ap.79','centro',81,5100102),
(82,'Principal939',42916604,'327','Ap.478','Lageadinho',82,5100102),
(83,'Principal510',66342497,'427','Ap.765','Lageadinho',83,5100102),
(84,'Principal726',22200273,'984','Ap.531','Lageadinho',84,5100359),
(85,'Principal397',54719117,'848','Ap.8','Lageadinho',85,5100359),
(86,'Principal891',70727315,'529','Ap.510','Lageadinho',86,5100359),
(87,'Principal156',63788245,'1290','Ap.349','Lageadinho',87,5100359),
(88,'Principal284',45133462,'3529','Ap.977','Nazar?',88,5000252),
(89,'Segunda86',34648257,'210','Ap.672','Nazar?',89,5000252),
(90,'Segunda846',16893469,'2459','Ap.463','Nazar?',90,5000203),
(91,'Segunda0',11507960,'1211','Ap.761','Nazar?',91,5000203),
(92,'Segunda417',97014067,'1046','Ap.67','Nazar?',92,5000203),
(93,'Segunda112',43541683,'971','Ap.34','Nazar?',93,5000203),
(94,'Segunda60',40409982,'3628','Ap.142','Nazar?',94,5000203),
(95,'Segunda84',86292736,'615','Ap.147','Vila Joana',95,1200179),
(96,'Segunda769',15780983,'202','Ap.90','Vila Joana',96,1200179),
(97,'Segunda325',42003495,'2963','Ap.888','Vila Joana',97,1200179),
(98,'Segunda807',38992290,'528','Ap.999','Vila Joana',98,1200179),
(99,'Segunda382',39280314,'3806','Ap.836','Vila Joana',99,1200179),
(100,'Segunda181',14104145,'1121','Ap.756','Vila Joana',100,1200179),
(101,'Segunda888',67742357,'3747','Ap.86','Vila Joana',101,1200344),
(102,'Segunda740',43607686,'161','Ap.309','Vila Joana',102,1200344),
(103,'Segunda852',26437445,'149','Ap.784','Vila Joana',103,1200344),
(104,'Segunda208',13230346,'1873','Ap.201','Vila Joana',104,1200344),
(105,'Segunda64',43821497,'2617','Ap.390','Vila Jardim Rio Claro',105,1200344),
(106,'Frias259',46547738,'37','Ap.350','Vila Jardim Rio Claro',106,1200807),
(107,'Frias101',78591289,'3789','Ap.162','Vila Jardim Rio Claro',107,1200807),
(108,'Frias238',33875521,'3213','Ap.991','Vila Jardim Rio Claro',108,1200807),
(109,'Frias756',65883967,'1105','Ap.572','Vila Jardim Rio Claro',109,1200807),
(110,'Frias375',59440779,'1175','Ap.1','Vila Jardim Rio Claro',110,1200807),
(111,'Frias586',44359600,'2618','Ap.976','Vila Jardim Rio Claro',111,1200807),
(112,'Frias95',79061786,'788','Ap.317','Vila Jardim Rio Claro',112,1200807),
(113,'Frias449',74370661,'1272','Ap.70','Vila Jardim Rio Claro',113,1200807),
(114,'Frias722',84353929,'1466','Ap.149','Vila Jardim Rio Claro',114,1200401),
(115,'Frias653',44076583,'656','Ap.151','Vila Jardim Rio Claro',115,1200401),
(116,'Frias435',59605564,'1798','Ap.324','Vila Jardim Rio Claro',116,1200401),
(117,'Frias632',46738685,'39','Ap.860','Rep?blica',117,1300201),
(118,'Frias335',53576133,'2038','Ap.151','Rep?blica',118,1300201),
(119,'Frias979',25254377,'2187','Ap.46','Rep?blica',119,1300201),
(120,'Frias859',40662648,'3366','Ap.873','Rep?blica',120,1300201),
(121,'Frias85',59086684,'1452','Ap.364','Rep?blica',121,1300201),
(122,'Frias246',89666014,'2025','Ap.408','Rep?blica',122,1300201),
(123,'Cunha405',99184892,'693','Ap.83','Rep?blica',123,1300201),
(124,'Cunha889',45078699,'97','Ap.40','Rep?blica',124,1300300),
(125,'Cunha676',13700005,'2262','Ap.66','Rep?blica',125,1300300),
(126,'Cunha663',90205132,'1523','Ap.433','Rep?blica',126,1300300),
(127,'Cunha810',87953933,'42','Ap.942','Rep?blica',127,1300300),
(128,'Cunha485',54747225,'2547','Ap.390','Rep?blica',128,1300300),
(129,'Cunha556',90216946,'1617','Ap.277','Rep?blica',129,1300300),
(130,'Cunha345',48511439,'1548','Ap.72','Casa Grande',130,2925303),
(131,'Cunha460',22149557,'1276','Ap.869','Casa Grande',131,2925303),
(132,'Cunha738',85920979,'803','Ap.270','Casa Grande',132,2925303),
(133,'Cunha882',93465741,'1458','Ap.335','Casa Grande',133,2925303),
(134,'Cunha263',92735998,'747','Ap.78','Casa Grande',134,2900702),
(135,'Cunha236',32218524,'1687','Ap.536','Casa Grande',135,2900702),
(136,'Cunha626',21336401,'1331','Ap.650','Casa Grande',136,2900702),
(137,'Cunha792',49335538,'248','Ap.723','Casa Grande',137,2900702),
(138,'Cunha265',96363649,'1113','Ap.259','Casa Grande',138,2913606),
(139,'Cunha820',63427809,'747','Ap.188','centro',139,2913606),
(140,'Cunha570',27094281,'933','Ap.839','Gramado',140,2913606),
(141,'Cunha173',85391715,'3725','Ap.93','Gramado',141,2913606),
(142,'Cunha63',96063442,'2975','Ap.262','Gramado',142,2913606),
(143,'Cunha232',87525237,'2631','Ap.354','Gramado',143,2913606),
(144,'Cunha837',31340282,'2549','Ap.790','Gramado',144,2601706),
(145,'Cunha468',51734299,'982','Ap.440','Gramado',145,2601706),
(146,'Cunha888',58454413,'3754','Ap.549','Gramado',146,2601706),
(147,'Cunha487',15952855,'3506','Ap.786','Gramado',147,2601706);





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
values(1,'Nefropatias'),(2,'Hepatopatias'),(3,'Diabetes'),(4,'Obesidade'),(5,'Transtornos Neurol?gicos'),(6,'Imunossupressos'),
(7,'Doen?as card?acas cr?nica');


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
values('O que ? o novo coronav?rus?','O nCoV ? uma nova cepa de coronav?rus que n?o havia sido previamente identificada em humanos.'),
('Qual ? a defini??o de caso suspeito?','O caso suspeito apresenta febre acompanhada de sintomas respirat?rios, al?m de atender a uma 
das duas seguintes situa??es: (a) ter viajado nos ?ltimos 14 dias antes do in?cio dos sintomas para ?rea de transmiss?o local ou
 (b) ter tido contato pr?ximo com casos suspeitos ou confirmados. Febre pode n?o estar presente em alguns pacientes, como idosos,
 imunocomprometidos ou que tenham utilizado antit?rmicos.'),
 ('Qual ? a orienta??o diante da detec??o de caso suspeito?','Os casos suspeitos
 devem ser mantidos em isolamento enquanto houver sinais e sintomas cl?nicos. Pacientes devem utilizar m?scara cir?rgica a partir do momento 
da suspeita e ser mantido preferencialmente em quarto privativo. Profissionais da sa?de devem utilizar medidas de precau??o padr?o, de contato
 e de got?culas (m?scara cir?rgica, luvas, avental n?o est?ril e ?culos de prote??o). Para a realiza??o de procedimentos que gerem aerossoliza??o 
de secre??es respirat?rias, como intuba??o, aspira??o de vias a?reas ou indu??o de escarro, dever? ser utilizada precau??o por aeross?is, com uso 
de m?scara profissional PFF2 (N95). Estas s?o recomenda??es atuais do Minist?rio da Sa?de.'),
('Qual ? o per?odo de incuba??o desta nova variante do coronav?rus?','Ainda n?o h? uma informa??o exata. Presume-se que o tempo de exposi??o ao v?rus 
e o in?cio dos sintomas seja de at? duas semanas, sendo que na maioria dos casos os sintomas aparecem entre o 5?. e 9?. dia ap?s infec??o.');



/*criacao de view para visualizar informacoes do user na pagina home*/
create or replace view info_perfil_home_vw
as 
select p.cod_usu,p.gen_pac,p.peso_pac,p.alt_pac,p.data_nasc_pac
from paciente p ;



/*cria??o de view para verificar se ja tem endereco cadastrado*/
create or replace view tem_cadastro_vw as
select p.cod_usu from paciente p 
inner join endereco e
on p.cod_pac = e.cod_pac;












/*criacao de view para visualizar informacoes do user na pagina de tela de informacoes*/
create or replace view tela_info_vw as
select pac.cod_pac,u.cod_usu,pac.nome_pac,pac.alt_pac,pac.peso_pac,pac.data_nasc_pac,pac.gen_pac,e.rua_end,e.num_end,e.comp_end,e.bai_end,c.nome_cid,es.nome_est 
from paciente pac
inner join endereco e on pac.cod_pac = e.cod_pac 
inner join cidade c on c.cod_cid = e.cod_cid 
inner join estado es on es.cod_est = c.cod_est
inner join usuario u on u.cod_usu = pac.cod_usu;


/*criacao de view para inserir dados do paciente*/
create view update_paciente_vw as
select p.nome_pac,p.gen_pac,p.alt_pac,p.peso_pac,p.data_nasc_pac,p.cod_usu from paciente p
inner join usuario u on u. cod_usu = p.cod_usu;

/*view para pegar a linha que vai ser feito o update do endereco*/
create or replace  view pega_pac_end_vw as 
select p.cod_pac,p.cod_usu,rua_end,num_end,comp_end,bai_end,cod_cid 
from endereco e 
inner join paciente p on p.cod_pac = e.cod_pac;

select * from pega_pac_end_vw;

select * from endereco p;
/*procedure para pegar os casos por regioes*/
delimiter $$

create or replace procedure casos_regiao(status varchar(30), regiao varchar(20))
		select count(*) as "total",s.des_status, re.nome_reg from paciente p 
		inner join status s on s.cod_status = p.cod_status
		inner join endereco e on e.cod_pac = p.cod_pac
		inner join cidade c on c.cod_cid = e.cod_cid 
		inner join estado es on es.cod_est = c.cod_est 
		inner join regiao re on re.cod_reg = es.cod_reg
			where des_status = status and nome_reg = regiao;

delimiter ;


call casos_regiao('Confirmado','Sul');


/*procedure para pegar casos gerais*/
delimiter $$
create or replace procedure casos_geral(status varchar(30))
		select count(*) as "total",s.des_status from paciente p 
		inner join status s on s.cod_status = p.cod_status
			where des_status = status;

delimiter ;

call casos_geral('Confirmado');










create or replace view pega_pac_vw as
select p.cod_usu,p.cod_pac from paciente p inner join usuario u on u.cod_usu = p.cod_usu
;





delimiter $$
create or replace procedure grava_endereco_perfil(cod int,rua varchar(30),cidade int)
	update pega_pac_end_vw set rua_end = rua,num_end =num,cod_cid = cidade,cod_pac =cod
where cod_usu = cod;

delimiter

,num int,comp varchar(15),comp_end = comp,bai_end = bai,
bai varchar(20),,nome varchar(50),gen char(1),alt numeric(3,2),peso numeric(5,2),data_nas date


call grava_endereco_perfil(2,'Principal03',2913606);


CREATE USER 'dev'@'localhost' IDENTIFIED BY 'PAS51#@22RD';
GRANT ALL PRIVILEGES ON * . * TO 'dev'@'localhost';


select * from usuario u;
select * from paciente p;
select * from endereco e;