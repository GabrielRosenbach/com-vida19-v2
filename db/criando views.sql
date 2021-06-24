create or replace view codigos_sintomas_vw as select s.codsin from public.sintoma s;
create or replace view estados_uf_minusculo_vw as select e.desest, lower(e.unifedest) as unifedest from public.estado e;

CREATE OR REPLACE view buscar_prontuarios_vw as
select 
		u.nomusu, 
		cast(extract(year from age(u.datnasusu)) as integer) as idausu, 
		g.desgen,
		c.nomcid,
		e.unifedest, 
		p.datcadpro, 
		sp.desstapro 
	from prontuario p
	inner join status_prontuario sp on sp.codstapro = p.codstapro
	inner join usuario u on u.codusu = p.codusu 
	inner join genero g on u.codgen = g.codgen 
	inner join cep_endereco ce on u.codcepend = ce.codcepend 
	inner join cidade c on c.codcid = ce.codcid 
	inner join estado e on c.codest = e.codest;