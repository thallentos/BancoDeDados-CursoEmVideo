create database Cadastro
default character set utf8mb4
default collate utf8mb4_general_ci;
/*drop database Cadastro;*/
use Cadastro;

/*Criar tabela*/
create table Pessoas(
`id` int not null auto_increment,
`nome` varchar(30) not null , /*obriga a pessoa a preencher*/
`nascimento` date,
`sexo` enum('M', 'F'), /*só serão aceitos esses valores no char*/
`peso` decimal(5,2), 
/*terá duas casas após a vírgula, sendo o 5 
  como quantidade total de casas. 
  Ex.: 106,92. Tem 5 casas e 2 são após a vírgula*/
`altura` decimal(3,2),
/*A mesma coisa que o código da parte de cima.
  Ex.: 1,73m*/
`nacionalidade` varchar(20) default 'Brasil',
primary key(id)
) default charset = utf8mb4;

/*Adicionar dados*/
insert into Pessoas
/*(id, nome, nascimento, sexo, peso, altura, nacionalidade)*/
/*Quando se sabe a posição de cada espaço, não precisa
	da parte de cima*/
values
/*(default, 'Alfonso', '1975-2-22', 'M', '100', '2.17', default),*//*Olha a vírgula*/
(null, default, 'Giovanna', 'Modelo','2000-06-18', 'F', '65.7', '1.68', 'Suécia'),
(null, default, 'Godofredo', 'Professor','1984-01-02', 'M', '78.5', 1.83, default);
/*(default, 'Lola', '1999-12-3', 'F', '70', '1.65', 'Gales');*//*Ponto e vírgula para terminar*/

select * from Pessoas;

/*Ver a tabela Pessoas*/
desc /*ou DESCRIBE*/Pessoas;

/*alterar tabelas*/
alter table Pessoas
/*adicionar uma coluna*/
add column profissão varchar(10) not null default'';

alter table Pessoas
/*Excluir a coluna 'profissão'*/
drop column profissão; 

/*Se eu quiser colocar um campo...:
  No primeiro:  first
  Após tal campo: after (nome do campo)
  Obs1.: Não existe BEFORE no MySQL
  Obs2.: A última posição é a padrão do campo*/

alter table Pessoas
add column profissão varchar(10) not null default '' after nome; 
/*criei a coluna 'profissão' DEPOIS da coluna 'nome'*/

alter table Pessoas
add /*column é opcional*/ código int first;

alter table Pessoas
/*modificar um campo de uma tabela*/
modify column profissão varchar(20) not null default '' after nome;
/*Coloquei a profissão depois do nome, sendo não nula,
  com o DEFAULT como espaço e tendo o varchar, que antes
  era 10, agora como 20*/
  
alter table Pessoas
/*mudar apenas o nome da coluna*/
change column profissão prof varchar(20) not null default '' after nome;
/*mudei o nome do campo de profissão para prof
  Para fazer isso tem que colocar o nome do campo atual,
  o nome do campo novo e todas as 
  constraints (especificações) do campo*/
  
/*modificar o nome da tabela inteira*/
alter table pessoas
rename to Pessoas;

alter table Pessoas
rename to Pessoas;

/*criar uma tabela se ela não existir*/
create table if not exists Cursos(
`nome` varchar(30) not null unique, 
	/*não pode ter 2 cursos com o mesmo nome*/
`descrição` text,
`carga` int unsigned, 
	/*o número não pode ter sinal*/
`total_aulas` int unsigned,
`ano` year default '2024'
) default charset = utf8mb4;

desc Cursos;

/*adicionei a coluna id_curso no topo da tabela*/
alter table Cursos
add column id_curso int first;

/*adicionei a primary key do id_curso*/
alter table Cursos
add primary key(id_curso);

/*apagar a tabela Cursos*/
drop table Cursos;
insert into Cursos values
('1','HTML4','Curso de HTML5','40','137','2014'),
('2','Algoritmos','Lógica de Programação','20','115','2014'),
('3','Photoshop','Dicas de Photoshop CC','10','8','2014'),
('4','PGP','Curso de PHP para iniciantes','40','20','2010'),
('5','Jarva','Introdução à Linguagem Java','10','29','2000'),
('6','MySQL','Bancos de Dados MySQL','30','15','2016'),
('7','Word','Curso completo de Word','40','30','2016'),
('8','Sapateado','Danças Rítmicas','40','30','2018'),
('9','Cozinha Árabe','Aprenda a fazer Kibe','40','30','2018'),
('10','Youtuber','Gerar polêmica e ganhar inscritos','5','2','2018');

select * from Cursos;
close;

/*mudar o dado de uma linha*/
update Cursos
set nome = 'HTML5'
/*atualizei o nome do curso para HTML5*/
where id_curso = '1';
/*onde o id_curso = '1'*/

update Cursos
set nome = 'PHP', ano = '2015'
where id_curso = '4';

update Cursos
set nome = 'Java', carga = '40', ano = '2015'
where id_curso = '5'
limit 1; /*limitar isso para uma linha para não correr o risco de modificar muitas coisas*/

/*excluir linhas de dados pelo id*/
delete from Cursos
where id_curso = '8';

/*excluir linha de dados pelo ano*/
delete from Cursos
where ano = '2018';

/*apagar TODAS as linhas de uma tabela, mas não a estrutura*/
/*truncate table Cursos;*/

/*Começando o estudo dos Selects*/

/*selecionei a tabela Cursos inteira
  em ordem alfabética*/
select * from Cursos
order by nome;

/*selecionei a tabela Cursos inteira
em ordem númerica decrescente*/
select * from Cursos
order by idcurso desc /*ou ASC de ascendente (menor para o maior)*/;

/*selecionei os parmâmetros nome, carga e ano
  na tabela Cursos*/
select nome, carga, ano from Cursos
order by nome;

/*a ordem dos parâmetros muda como eles
  serão impressos*/
select ano, nome, carga from Cursos
order by ano;

/*primeiro foi ordenado por ano e 
  depois pelo nome*/
select ano, nome, carga from Cursos
order by ano, nome;

/*selecionei todos os cursos onde
  o ano foi 2016*/
select * from cursos
where ano = '2016'
order by nome;

/*selecionei o nome e os cursos de 2016
  sem mostrar na tela o ano de 2016,
  porque isso já está subentendido*/
select nome, carga from cursos
where ano = '2016'
order by nome;

/*selecionei o nome e a descrição dos
  cursos que foram lançados até 2015*/
select nome, descricao from Cursos
where ano <= '2015'
order by nome;

/*selecionei os cursos que foram lançados
  entre 2014 e 2016, ordenando primeiramente
  o ano para decrescente e, dentro dele,
  o nome para crescente*/
select nome, ano from Cursos
where ano between 2014 and 2016
order by ano desc, nome asc;

/*selecionei o idcurso, nome e o ano
  onde o ano seja 2014, 2016 ou 2018,
  ordenando por ano*/
select idcurso, nome, ano from Cursos
where ano in ('2014', '2016', '2018')
order by ano;

/*selecionei o nome, carga e o total de aulas
  onde a carga seja maior que 35 *E* o total de
  aulas seja menor do que 30*/
select nome, carga, totaulas from Cursos
where carga > 35 and totaulas < 30;

/*selecionei o nome, carga e o total de aulas
  onde a carga seja maior que 35 *OU* o total de
  aulas seja menor do que 30*/
select nome, carga, totaulas from Cursos
where carga > 35 or totaulas < 30;

/*selecionei todos os campos de cursos
  que COMEÇAM com a letra 'P'*/
select * from Cursos
where nome like 'P%'
/*LIKE significa parecido, ou seja,
  o nome dos cursos que o começo se
  pareça com a letra 'P'*/
/*esse % signfica que ele vai substituir
  por tudo (ou nada, se não houver),
  desde que comece com a letra 'P'.
  A posição do % importa*/
order by nome;

/*selecionei todos os campos dos cursos
  que TERMINEM com a letra 'A'*/
select * from Cursos
where nome like '%A'
order by nome;

/*selecionei todos os campos dos cursos
  que CONTENHAM com a letra 'A'*/
select * from Cursos
where nome like '%A%'
order by nome;

/*selecionei todos os campos dos cursos
  que NÂO CONTENHAM com a letra 'A'*/
select * from Cursos
where nome not like '%A%'
/*o resultado de não conter 'A' acontece
  por causa do código NOT*/
order by nome;

/*selecionei todos os cursos
  que tenham PH no começo e que terminem
  com P e que tenham mais 1 caracter obrigatório*/
select * from Cursos
where nome like 'PH%P_';

/*selecionei todos os cursos que comecem com P,
  tenham mais 1 caracter, terminem com P e tenham
  qualquer coisa (ou nada, caso não haja) após ele*/
select * from Cursos
where nome like 'p_p%'
order by nome;

/*selecionei todos os cursos que comecem com P,
  tenham mais 2 caracteres, terminem com T e
  tenham qualquer coisa (ou nada, caso não haja)
  após ele*/
select * from Cursos
where nome like 'p__t%'
order by nome;

/*selecionei todos os nome onde tenha o sobrenome
  Silva*/
select * from gafanhotos
where nome like '%_silva%'
order by nome;

/*selecionei todas as nacionalidades da tabela gafanhotos
  ordenada por nacionalidade.
  O DISTINCT serve para mostrar apenas 1 vez um dado que
  esteja repetido, mas ele não só mostra só o dado repetido*/
select distinct nacionalidade from gafanhotos
order by nacionalidade;

/*
*
*
*
MÉTODO COUNT()
*
*
*
*/
/*contou todas as linhas(vertical) 
  da tabela Cursos*/
select count(*) from Cursos;

/*fiz uma seleção para contar
  todos os cursos que tem carga
  maior que 40*/
select count(*) from Cursos
where carga > 40;

/*
*
*
*
MÉTODO MAX()
*
*
*
*/
/*fiz uma seleção para mostrar o máximo
  de carga entre todos os cursos*/
select max(carga) from Cursos;

/*fiz uma seleção do máximo de 
  total de aulas em 2016*/
select max(totaulas) from Cursos
where ano = '2016';

/*
*
*
*
MÉTODO MIN()
*
*
*
*/
/*fiz uma seleção para mostrar o mínimo
  aulas que teve no ano de 2016*/
select min(totaulas) from Cursos 
where ano = '2016';

/*
*
*
*
MÉTODO SUM()
*
*
*
*/
/*fiz uma seleção que soma todas
  as aulas do ano de 2016
  na tabela Cursos*/
select sum(totaulas) from Cursos
where ano = '2016';

/*
*
*
*
MÉTODO AVG()
*
*
*
*/
/*somei o total de todas as aulas de Cursos*/
select sum(totaulas) from Cursos; /*583*/
/*contei todos os nomes de Cursos*/ /*30*/
select count(nome) from Cursos;
/* 583/30 = 19,43.. */
select avg(totaulas) from Cursos;

/*selecionei a média do total de aulas
  da tabela Cursos onde o ano seja
  igual a 2016*/
select avg(totaulas) from Cursos
where ano = '2016';

/*
*
*
*
EXERCÍCIOSSSS
*
*
*
*/

/*
1) Selecionar o nome de todas as gafanhotas
*/
select nome from Gafanhotos
where sexo = 'F'
order by nome;

/*
2) Selecionar os dados
   de todos os que nasceram entre 1/Jan/2000
   e 31/Dez/2015
*/
select * from Gafanhotos
where nascimento between 
'2000-01-01' and '2015-12-31'
order by nascimento;

/*
3) Selecionar o nome de todos os 
   homens que trabalham como 
   Programadores
*/
select nome from Gafanhotos
where sexo = 'M' and
profissao = 'Programador'
order by nome;

/*
4) Selecionar os dados de todas
   as mulheres que nasceram no Brasil
   e tem seu nome iniciado com 
   a letra J
*/
select * from Gafanhotos
where sexo = 'F' 
and nacionalidade = 'Brasil'
and nome like 'J%';

/*
5) Selecionar o nome e a nacionalidade
   de todos os homens que têm Silva no nome,
   não nasceram no Brasil e pesam menos de 100kg
*/
select nome, nacionalidade, peso from Gafanhotos
where sexo = 'M' 
and nome like '%Silva%' 
and nacionalidade != 'Brasil' 
and peso < '100';

/*
6) Selecionar a maior altura 
   entre gafanhotos homens 
   que moram no Brasil
*/
select max(altura) from Gafanhotos
where sexo = 'M' 
and nacionalidade = 'Brasil';

/*
7) Selecionar a média de peso
   dos gafanhotos cadastrados
*/
select avg(peso) from Gafanhotos;

/*
8) Selecionar o menor peso entre
   as gafanhotos mulheres que nasceram
   fora do Brasil entre 01/Jan/1990 e
   31/Dez/2000
*/
select min(peso)from Gafanhotos
where sexo = 'F' 
and nacionalidade != 'Brasil' 
and nascimento between '1990-01-01' 
and '2000-12-31';

/*
9) Selecionar quantas gafanhotas mulheres
   têm mais de 1.90 de altura
*/
select nome, altura from Gafanhotos
where sexo = 'F' 
and altura > 1.90
order by altura desc;

/*
*
*
*
MÉTODO DE ORDENAÇÃO
(((GROUP BY)))
*
*
*
*/

/*fiz um select agrupando os iguais.
  Não significa que só tem um curso com
  carga 40, por exemplo; mas que todos
  os cursos com cargas iguais estão agrupados
  e implícitos, mas estão lá*/
select carga from Cursos
group by carga;

/*Aqui dá para ver a quantidade de cada 
  curso com a carga selecionada*/
select count(nome), carga from Cursos
group by carga;

/*
*
*
*
MÉTODO DE ORDENAÇÃO
(((GROUP BY)))
*
*
*
*/
/*selecionei a quantidade de nome e a
  carga, agrupados pela carga e que
  TENHA mais de 8 Cursos, ou seja, mostrar
  cargas iguais em que se tenham mais de
  8 Cursos.*/
select count(nome), carga from Cursos
group by carga
having count(nome) > 8;

/*selecionei o ano e a quantidade de Cursos 
  desse ano agrupado por cada ano, porém 
  só vai mostrar na tela os anos em que 
  se tenha mais (ou igual) 4 Cursos
  */
select ano, count(ano) from Cursos
group by ano
having count(ano) >= 4
/*só pode usar o having com o
  CAMPO QUE VOCÊ AGRUPOU*/
order by count(ano);

/*selecionei a carga e a quantidade de cursos
  onde o ano seja maior que 2015,
  agrupados por carga e que a carga de cada
  agrupamento seja maior que a média de
  média de carga de todos os cursos*/
select carga, count(*) from Cursos
where ano > 2015
group by carga
having carga > (select avg(carga) from Cursos)
order by carga;

/*
*
*
*
EXERCÍCIOSSSS
*
*
*
*/
/*
1) Selecionar as profissões dos gafanhotos
   e seus respectivos quantitativos
*/
select profissao, count(profissao) from Gafanhotos
group by profissao
order by count(profissao);

/*
2) Selecionar quantos gafanhotos homens
   e quantas gafanhotas mulheres nasceram
   após 01/Jan/2005
*/
select sexo, count(*) from Gafanhotos
where nascimento > '2005-01-01'
group by sexo;

/*
3) Selecionar os gafanhotos que nasceram fora
   do Brasil, mostrando o país de origem e o total
   de pessoas nascidas lá. Só nos interessam os países
   que tiveram mais de 3 gafanhotos com essa nacionalidade
*/
select nacionalidade, count(*) from Gafanhotos
where nacionalidade != 'Brasil'
group by nacionalidade
having count(nacionalidade) > 3
order by count(nacionalidade);

/*
4) Selecionar gafanhotos agrupados pela altura,
   mostrando quantas pessoas pesam mais de 100kg
   e que estão acima da média de altura de todos
   os cadastrados
*/
select altura, count(altura) from Gafanhotos
where peso > 100
group by altura
having altura > (select avg(altura) from Gafanhotos)
order by altura;

/*
*
*
*
ADICIONANDO UMA FOREIGN KEY
*
*
*
*/
/*dei um describe para ver as colunas da tabela*/
describe Gafanhotos;

/*adicionei uma coluna na tabela Gafanhotos*/
alter table Gafanhotos
add column curso_preferido int;

/*denominei uma foreign key
  na tabela Gafanhotos, referenciando-a
  à tabela Cursos*/
alter table Gafanhotos
add foreign key(curso_preferido)
references Cursos(idcurso); 

/*atualizei as informações de curso_preferido
  para ser igual a 6 onde o id (da pessoa)
  for igual a 1*/
update Gafanhotos
set curso_preferido = '6'
where id = '1';

/*
*
*
*
USANDO O INNER JOIN
*
*
*
*/

/*INNER significa 'igual' e 'join' significa 'ligação,
  ou seja, o inner join faz uma ligação dos dados que
  são iguais*/
  
/*selecionei, na tabela Gafanhotos, os nomes deles.
  Na tabela Cursos selecionei os nomes (dos cursos)
  e o ano deles. Usei o FROM para fazer referência às
  respectivas tabelas e fiz um INNER JOIN entre elas.
  Para isso, mostrei que o idcurso da tabela Cursos
  é igual (INNER) a curso_preferido da tabela Gafanhotos.
  Portanto, o SELECT me mostrou a junção dos valores iguais
  entre as duas tabelas*/
select gafanhotos.nome, cursos.nome, cursos.ano
from gafanhotos inner join cursos
/*SEMPRE tem que usar o ON*/
on cursos.idcurso = gafanhotos.curso_preferido
order by gafanhotos.nome;
  
/*fiz a mesma coisa, a diferença é que eu dei
  o nome de "g" para gafanhotos e "c" para cursos*/
select g.nome, c.nome, c.ano
/*esse AS ajuda muito*/
from gafanhotos as g inner join cursos as c
/*SEMPRE tem que usar o ON*/
on c.idcurso = g.curso_preferido
order by g.nome;

/*LEFT OUTER JOIN: preferência pra tabela da esquerda
  RIGHT OUTER JOIN: preferência pra tabela da direita*/
select g.nome, c.nome, c.ano
/*esse AS ajuda muito*/
from gafanhotos as g right /*o OUTER é opcional*/ join cursos as c
/*SEMPRE tem que usar o ON*/
on c.idcurso = g.curso_preferido
order by g.nome;

/*
*
*
*
RELACIONAMENTOS
*
*
*
*/

/*
Quando o relacionamento é de [1 -> 1] (lê-se, um para um)
então devemos pegar a chave primária de cada um
e passá-la como chave estrangeira para outro o outro.
Ex.: (chave-primária de A) 1 -> 1 (chave-primária de B)
invertendo fica:
((chave-primária de A) e (chave ESTRANGEIRA de B)) 1 - > 1 ((chave-ESTRANGEIRA de A) e (chave-primária de B))
porque aí cada um fica com a sua própria 
chave-primária e também tem a chave 
estrangeira do outro
*/

/*
Quando o relacionamento é de [1 -> n] (lê-se, um para n)
Vamos pegar a chave-primária de do 1 e passá-la para o n
Começo do processo:
(chave-primária de A) 1 -> n
No final ficará assim:
(chave-primária de A) 1 -> n (chave ESTRANGEIRA de A)
*/

/*
Quando o relacionamento é de [n -> n] (lê-se, n para n)
Aí fica igual o Heráclito falou, o relacionamento 
entre os dois vira uma entidade. Portanto, vira mais uma tabela
E é isso que será feito agora. 
O relacionamento da tabela Gafanhotos e da tabela Cursos terá
uma outra tabela (entre elas) para serem colocadas as chaves-primárias de A e B
nessa nova tabela, o que ficará com 2 chaves estrangeiras de A e B
*/

/*
*
*
*
FAZENDO INNER JOIN 
COM VÁRIAS TABELAS
*
*
*
*/

/*mudei o nome da coluna da tabela Cursos
  de "idcurso" para "id"*/
alter table cursos
change column idcurso id int;

/*criando a tabela da entidade que está entre
  gafanhotos e cursos*/
create table gafanhoto_assiste_curso (
	id int not null auto_increment,
    data date,
    idgafanhoto int,
    idcurso int,
    primary key (id), /*se refere ao "id" da linha 722*/
    /*o idgafanhoto foi criado agora e faz referência
      ao "id" da tabela gafanhotos. Por isso está aparecendo
      "gafanhotos(id)"*/
    foreign key (idgafanhoto) references gafanhotos(id),
	/*o idcurso foi criado agora e faz referência
	  ao "id" da tabela cursos. Por isso está aparecendo
      "cursos(id)"*/
    foreign key (idcurso) references cursos(id)
) default charset = utf8mb4;

/*inserindo dados nessa tabela*/
insert into gafanhoto_assiste_curso values
(default, '2014-03-01', '1', '2');

select * from gafanhoto_assiste_curso;

/*fazendo uma junção dentro de outra*/
select * from gafanhotos g
inner join gafanhoto_assiste_curso a
on g.id = a.idgafanhoto;

/*o Daniel Morais faz 2 cursos, um tem o id '2' e outro '19'.
  E por aí vai com as outras pessoas 
  que estão fazendo outros cursos*/
select g.nome, idcurso from gafanhotos g
inner join gafanhoto_assiste_curso a
on g.id = a.idgafanhoto
order by g.nome;

/*selecionei o nome (tabela Gafanhotos),
  nome (Cursos), idcurso (gafanhoto_assiste_curso)
  e id (Cursos) e fiz 2 inner join para mostrar isso.
  Daí eu igualei as primary keys para que isso seja
  feito do jeito certo*/
select g.nome, c.nome, a.idcurso, c.id from gafanhotos g
inner join gafanhoto_assiste_curso a
on g.id = a.idgafanhoto
inner join cursos c
on c.id = a.idcurso
order by g.nome;

/*ACABOOOOOU!!*/