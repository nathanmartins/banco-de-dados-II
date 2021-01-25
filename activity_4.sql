-- ALUNO: Nathan Santos Martins

--- Nome do autor que tem livro com estoque zerado.

select nome
from autor
where idautor in (select idautor from escreve where idlivro in (select idlivro from livro where estoque = 0));

----------------------------------------------------

--- Nomes dos Clientes que compraram livros do autor "Hilary Duff"

select nome
from cliente
where idcliente in (select idcliente
                    from venda
                    where idvenda in (select idvenda
                                      from itens_da_venda
                                      where idlivro in (select idlivro
                                                        from escreve
                                                        where idautor in (select idautor from autor where nome = 'Hilary Duff'))));
----------------------------------------------------

--- Quais gêneros o cliente "Elaine Luciana" gosta de ler?

select descricao
from genero
where idgenero in (select idgenero
                   from livro
                   where idlivro in (select idlivro
                                     from itens_da_venda
                                     where idvenda in (select idvenda
                                                       from venda
                                                       where idcliente in (select idcliente from cliente where nome = 'Elaine Luciana'))));

----------------------------------------------------

--- Quais livros do autor "Daniel Kahneman" tem em estoque?

select titulo
from livro
where idlivro in
      (select idlivro from escreve where idautor in (select idautor from autor where nome = 'Daniel Kahneman'))
  and estoque > 0;

----------------------------------------------------

--- Que cliente já comprou livro da editora "Benvirá"?

select nome
from cliente
where idcliente in (select idcliente
                    from venda
                    where idvenda in (select idvenda
                                      from itens_da_venda
                                      where idlivro in (select idlivro
                                                        from livro
                                                        where ideditora in (select ideditora from editora where nome = 'Benvirá'))));

----------------------------------------------------

--- Quais autores venderam 2 ou mais exemplares de seu livro numa única venda?

select nome
from autor
where idautor in (select idautor
                  from escreve
                  where idlivro in
                        (select idlivro
                         from livro
                         where idlivro in (select idlivro from itens_da_venda where qtd >= 2)));

----------------------------------------------------

--- Qual livro teve o maior número de exemplares vendidos de uma só vez?
select titulo
from livro
where idlivro in (select idlivro from itens_da_venda where qtd = (select max(qtd) from itens_da_venda));

----------------------------------------------------

---  Quem comprou o livro mais caro?

select nome
from cliente
where idcliente in (select idcliente
                    from venda
                    where idvenda in (select idvenda
                                      from itens_da_venda
                                      where idlivro in
                                            (select idlivro from livro where preco = (select max(preco) from livro))));

----------------------------------------------------

--- Qual autor tem o livro mais barato?

select nome
from autor
where idautor in (select idautor
                  from escreve
                  where idlivro in (select idlivro from livro where preco = (select min(preco) from livro)));

----------------------------------------------------

---  Qual a média de preço dos livros por gênero?

select g.descricao, AVG(l.preco)
from livro l
         join genero g on l.idgenero = g.idgenero
group by g.descricao;

----------------------------------------------------

--- Qual seria o valor total para comprar um exemplar do livro mais barato de cada genero?

select sum(x.min_pre)
from (select min(preco) as min_pre from livro group by idgenero) x;

----------------------------------------------------
