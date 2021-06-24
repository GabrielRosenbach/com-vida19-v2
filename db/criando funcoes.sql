
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


CREATE OR REPLACE function salvar_conta (
	codusuario int = null, 
	nome varchar = null, 
	datanasc date = null, 
	codgenero int = null, 
	avatar bytea = null, 
	login varchar = null, 
	senha varchar = null, 
	cep int4 = null
)
RETURNS varchar
as $body$
declare 
encrypt varchar;
codigoUsuario int;
codigoCepEnd int;
begin
	select ce.codcepend into codigoCepEnd from cep_endereco ce where ce.numcep = cep;
	
  	if codusuario is null then 
	    INSERT INTO usuario (nomusu, datnasusu, codgen, codcepend, avausu, logusu, senusu) 
	   		VALUES (nome, datanasc, codgenero, codigoCepEnd, avatar, login, senha);
	   	
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
$body$ LANGUAGE 'plpgsql';


