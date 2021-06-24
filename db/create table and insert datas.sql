create table estado (
	codest serial primary key, 
	desest varchar(20) not null,
	unifedest char(2) not null
);

create table cidade (
	codcid serial primary key, 
	codest integer not null,
	nomcid varchar(30) not null,
	constraint cidade_codest_fk foreign key (codest) references estado (codest)
);

create table cep_endereco (
	codcepend serial primary key, 
	codcid integer not null,
	numcep integer not null,
	constraint cep_codcid_fk foreign key (codcid) references cidade (codcid)
);

create table genero (
	codgen serial primary key,
	desgen varchar(15) not null
);

create table usuario (
	codusu serial primary key, 
	codgen integer not null, 
	codcepend integer not null,
	nomusu varchar(50) not null,
	datnasusu date not null, 
	avausu bytea, 
	logusu varchar(20) not null,
	senusu varchar(32) not null,
	aceusu varchar(32),
	constraint usuario_codgen_fk foreign key (codgen) references genero (codgen),
	constraint usuario_codcepend_fk foreign key (codcepend) references cep_endereco (codcepend)
);

create table sintoma (
	codsin serial primary key, 
	dessin varchar(30) not null
);

create table intensidade (
	codint serial primary key, 
	desint varchar(10) not null
);

create table prontuario (
	codpro serial primary key, 
	codusu integer not null, 
	datcadpro date not null,
	retpro boolean,
	datretpro date,
	constraint prontuario_codusu_fk foreign key (codusu) references usuario (codusu)
);

create table prontuario_sintoma (
	codsinpro serial primary key, 
	codpro integer not null, 
	codsin integer not null, 
	codint integer not null, 
	constraint prontuario_sintomas_codpro_fk foreign key (codpro) references prontuario (codpro),
	constraint prontuario_sintomas_codsin_fk foreign key (codsin) references sintoma (codsin),
	constraint prontuario_sintomas_codint_fk foreign key (codint) references intensidade (codint)
);


/***********************************************************/
 

insert into estado (codest, desest, unifedest) values (1, 'Rio Grande do Sul', 'RS');
insert into estado (codest, desest, unifedest) values (2, 'Santa Catarina', 'SC');
insert into estado (codest, desest, unifedest) values (3, 'Paraná', 'PR');

insert into estado (codest, desest, unifedest) values (4, 'São Paulo', 'SP');
insert into estado (codest, desest, unifedest) values (5, 'Rio de Janeiro', 'RJ');
insert into estado (codest, desest, unifedest) values (6, 'Espírito Santo', 'ES');
insert into estado (codest, desest, unifedest) values (7, 'Minas Gerais', 'MG');

insert into estado (codest, desest, unifedest) values (8, 'Goiás', 'GO');
insert into estado (codest, desest, unifedest) values (9, 'Mato Grosso', 'MT');
insert into estado (codest, desest, unifedest) values (10, 'Mato Grosso do Sul', 'MS');

insert into estado (codest, desest, unifedest) values (11, 'Alagoas', 'AL');
insert into estado (codest, desest, unifedest) values (12, 'Bahia', 'BA');
insert into estado (codest, desest, unifedest) values (13, 'Ceará', 'CE');
insert into estado (codest, desest, unifedest) values (14, 'Maranhão', 'MA');
insert into estado (codest, desest, unifedest) values (15, 'Paraíba', 'PB');
insert into estado (codest, desest, unifedest) values (16, 'Pernambuco', 'PE');
insert into estado (codest, desest, unifedest) values (17, 'Piauí', 'PI');
insert into estado (codest, desest, unifedest) values (18, 'Rio Grande do Norte', 'RN');
insert into estado (codest, desest, unifedest) values (19, 'Sergipe', 'SE');

insert into estado (codest, desest, unifedest) values (20, 'Acre', 'AC');
insert into estado (codest, desest, unifedest) values (21, 'Amapá', 'AP');
insert into estado (codest, desest, unifedest) values (22, 'Amazonas', 'AM');
insert into estado (codest, desest, unifedest) values (23, 'Pará', 'PA');
insert into estado (codest, desest, unifedest) values (24, 'Rondônia', 'RO');
insert into estado (codest, desest, unifedest) values (25, 'Roraima', 'RR');
insert into estado (codest, desest, unifedest) values (26, 'Tocantins', 'TO');


insert into genero (codgen, desgen) values (1, 'MASCULINO');
insert into genero (codgen, desgen) values (2, 'FEMININO');

insert into sintoma (codsin, dessin) values (1, 'Febre');
insert into sintoma (codsin, dessin) values (2, 'Tosse Seca');
insert into sintoma (codsin, dessin) values (3, 'Cansaço');
insert into sintoma (codsin, dessin) values (4, 'Dor de Garganta');
insert into sintoma (codsin, dessin) values (5, 'Diarreia');
insert into sintoma (codsin, dessin) values (6, 'Conjuntivite');
insert into sintoma (codsin, dessin) values (7, 'Dor de Cabeça');
insert into sintoma (codsin, dessin) values (8, 'Perda de Paladar ou Olfato');
insert into sintoma (codsin, dessin) values (9, 'Dificuldade de Respirar');
insert into sintoma (codsin, dessin) values (10, 'Dor no Peito');
insert into sintoma (codsin, dessin) values (11, 'Dores no Corpo');
insert into sintoma (codsin, dessin) values (12, 'Perda de Fala ou Movimento');


insert into intensidade (codint, desint) values (1, 'Leve');
insert into intensidade (codint, desint) values (2, 'Moderada');
insert into intensidade (codint, desint) values (3, 'Elevada');