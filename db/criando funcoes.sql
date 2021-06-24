
/******************BUSCAR CIDADE E ESTADO****************************/

CREATE OR REPLACE function buscar_cidade_estado (cep int4)
RETURNS table (nomcid varchar, desest varchar) 
AS
$body$
begin
	
	RETURN QUERY SELECT ci.nomcid, es.desest FROM cep_endereco AS ce 
        INNER JOIN cidade AS ci ON ce.codcid = ci.codcid 
        INNER JOIN estado AS es ON es.codest = ci.codest 
    	WHERE ce.numcep = cep;
END;
$body$ LANGUAGE 'plpgsql';

/******************SALVAR CEP_ENDERECO****************************/

CREATE OR REPLACE function salvar_cidade_cep_endereco (uf CHAR(2), nomeCidade VARCHAR(30), cep int4)
RETURNS table(nomcid varchar, desest varchar)  
AS
$body$
DECLARE 
codigoEstado int4;
codigoCidade int4;
existeCepCadastrado boolean default false;
begin
	
   	SELECT true into existeCepCadastrado FROM cep_endereco WHERE numcep = cep limit 1;
   
  	if not found then 
	
	    SELECT e.codest INTO codigoEstado FROM estado as e WHERE e.unifedest = uf;
	    
	    SELECT c.codcid INTO codigoCidade FROM cidade as c WHERE c.nomcid = nomeCidade;
	    
	    IF NOT FOUND then
	    	INSERT INTO cidade (codest, nomcid) VALUES (codigoEstado, nomeCidade);
	    	SELECT MAX(c.codcid) INTO codigoCidade FROM cidade as c; 	
	    END IF;
	   
	   
	    INSERT INTO cep_endereco (codcid, numcep) VALUES (codigoCidade, cep);
		return query select * from buscar_cidade_estado(cep);
	end if;
END;
$body$ LANGUAGE 'plpgsql';

/******************SALVAR CONTA****************************/


CREATE OR REPLACE FUNCTION public.salvar_conta(codusuario integer DEFAULT NULL::integer, nome character varying DEFAULT NULL::character varying, datanasc date DEFAULT NULL::date, codgenero integer DEFAULT NULL::integer, avatar bytea DEFAULT NULL::bytea, login character varying DEFAULT NULL::character varying, senha character varying DEFAULT NULL::character varying, cep integer DEFAULT NULL::integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare 
encrypt varchar;
codigoUsuario int;
codigoCepEnd int;
begin
	select ce.codcepend into codigoCepEnd from cep_endereco ce where ce.numcep = cep;
	
  	if codusuario is null then 
	    INSERT INTO usuario (nomusu, datnasusu, codgen, codcepend, avausu, logusu, senusu, admusu) 
	   		VALUES (nome, datanasc, codgenero, codigoCepEnd, avatar, login, senha, false);
	   	
   		select max(codusu) into codigoUsuario from usuario;
   	else
   		codigoUsuario := codusuario;
		if avatar is null then 
			update usuario set nomusu = nome, datnasusu = datanasc, codgen = codgenero, 
				codcepend = codigoCepEnd, logusu = login, senusu = senha
				where codusu = codusuario;
		else 
			update usuario set nomusu = nome, datnasusu = datanasc, codgen = codgenero, 
				codcepend = codigoCepEnd, logusu = login, senusu = senha, avausu = avatar
				where codusu = codusuario;
		end if;
	end if;

	encrypt := login || codigoUsuario || senha || '$key-encrypt_2021$';

	encrypt := md5(encrypt);

	update usuario set aceusu = encrypt where codusu = codigoUsuario;
	
	return encrypt;
END;
$function$
;

/******************SALVAR PRONTUARIO****************************/

CREATE OR REPLACE FUNCTION public.salvar_prontuario(ticketacesso character varying, status int)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
declare
codigoUsuario int;
begin
	
	select u.codusu into codigoUsuario from usuario u where u.aceusu = ticketAcesso;

	insert into prontuario (codusu, datcadpro, codstapro) values (codigoUsuario, current_date, status);
	return max(p.codpro) from prontuario p;
END;
$function$
;


/******************BUSCAR PRONTUARIOS DO USUARIO****************************/

CREATE OR REPLACE FUNCTION public.buscar_prontuarios_usuario(ticketAcesso varchar)
 RETURNS TABLE(datcadpro date, desstapro character varying)
 LANGUAGE plpgsql
AS $function$
begin
	
	RETURN QUERY select p.datcadpro, sp.desstapro from prontuario p
	inner join status_prontuario sp on sp.codstapro = p.codstapro
	inner join usuario u on u.codusu = p.codusu 
	where u.aceusu = ticketAcesso;
END;
$function$
;



