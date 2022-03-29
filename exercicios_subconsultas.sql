use empresa;

/*Utilizando subconsultas*/

/*1. Listar o nome e sexo dos funcionarios que ganham mais que R$ 1400*/
SELECT f.nome, f.sexo
FROM funcionario f
WHERE f.cod_cargo IN (
	SELECT c.cod_cargo 
	FROM cargo c
	WHERE c.salario > '1400'
);

/*2. Listar as informações dos cargos que possuem ao menos um funcionario*/
SELECT * FROM cargo c
WHERE c.cod_cargo IN (
	SELECT cod_cargo
	FROM funcionario
    WHERE cod_cargo >= 1
);

/*3. Listar as informações dos cargos que não possuem funcionários*/
SELECT * FROM cargo c
WHERE c.cod_cargo NOT IN (
	SELECT cod_cargo
	FROM funcionario
);

/*4. Listar o nome, data de admissão e sexo dos funcionarios do departamento Financeiro*/
SELECT f.nome, f.data_adm, f.sexo
FROM funcionario f
WHERE f.cod_depto IN (
	SELECT cod_depto FROM departamento
    WHERE nome = 'financeiro'
);

/*5. Listar os dados dos funcionários de sexo masculino que foram contratados antes de Janete Rosa*/
SELECT * FROM funcionario f
WHERE sexo = 'M'
AND f.data_adm < (
	SELECT data_adm FROM funcionario
	WHERE nome = 'Janete Rosa'
);

/*6. Listar o nome dos departamentos que não fizeram contratações em 2008*/
SELECT d.nome FROM departamento d
WHERE d.cod_depto IN (
	SELECT cod_depto
	FROM funcionario
	WHERE YEAR(data_adm) != 2008
);

/*1. Listar as informações do cargo de maior salário*/
SELECT * FROM cargo c
WHERE c.salario IN (
	SELECT MAX(c.salario) FROM cargo c
);

/*2. Para o funcionário mais antigo da empresa listar: nome do funcionário, o nome do cargo e nível e nome do seu departamento*/
SELECT f.nome AS nome_func, c.nome AS nome_cargo, c.nivel, d.nome AS nome_depto
FROM funcionario f 
INNER JOIN cargo c ON f.cod_cargo = c.cod_cargo
INNER JOIN departamento d ON f.cod_depto = d.cod_depto
WHERE f.data_adm IN (
	SELECT MIN(f.data_adm) FROM funcionario f
); 

/*3. Listar os dados de todos os funcionários da empresa, exceto do que foi contratado mais recentemente*/
SELECT * FROM funcionario f
WHERE f.data_adm NOT IN (
	SELECT MAX(f.data_adm) FROM funcionario f
);

/*4. Listar os dados dos departamentos que possuem funcionários do sexo feminino*/
SELECT * FROM departamento d
WHERE d.cod_depto IN (
	SELECT f.cod_depto
	FROM funcionario f
	WHERE sexo = 'F'
);

/*5. Listar o nome e nível dos cargos dos funcionários de sexo masculino*/
SELECT c.nome, c.nivel
FROM cargo c
WHERE c.cod_cargo IN (
	SELECT cod_cargo
    FROM funcionario
    WHERE sexo = 'M'
);

/*6. Listar os dados dos cargos que possuem funcionários, mas não possuem funcionários do sexo feminino*/
SELECT * FROM cargo
WHERE cod_cargo IN (
	SELECT cod_cargo
    FROM funcionario
    WHERE nome IS NOT NULL)
AND cod_cargo NOT IN (
	SELECT cod_cargo
    FROM funcionario
    WHERE sexo = 'F'
);
