-- ALUNO: Nathan Santos Martins

select count(1)
from ator;

----------------------------------------------------

select SUM(valor) AS total
from pagamento;

----------------------------------------------------

select distinct classificacao
from filme;

----------------------------------------------------

select classificacao, count(1)
from filme
group by classificacao;

----------------------------------------------------

select *
from ator
         cross join filme;

----------------------------------------------------

select r.primeiro_nome || ' ' || r.ultimo_nome as nome_do_ator, i.titulo
from ator r
         join filme_ator ri on ri.ator_id = r.ator_id
         join filme i on i.filme_id = ri.filme_id;

----------------------------------------------------

select  r.ator_id, count(r.ator_id)
from ator r
         join filme_ator ri on ri.ator_id = r.ator_id
         join filme i on i.filme_id = ri.filme_id
group by r.ator_id;

----------------------------------------------------

select
    concat(r.primeiro_nome,' ',r.ultimo_nome ) as merged_columns,
    count(concat(r.primeiro_nome,' ',r.ultimo_nome ))
from
    ator r
        join filme_ator ri on ri.ator_id = r.ator_id
        join filme i on i.filme_id = ri.filme_id
group by 1
order by merged_columns desc;

----------------------------------------------------

select concat(bb.primeiro_nome, ' ', bb.ultimo_nome) as nome_cliente, count(aa.cliente_id) as alugeis
from aluguel aa
         join cliente bb on aa.cliente_id = bb.cliente_id
group by 1
order by alugeis desc limit 10;

----------------------------------------------------

select  i.titulo, count(r.ator_id) as quant_atores
from ator r
         join filme_ator ri on ri.ator_id = r.ator_id
         join filme i on i.filme_id = ri.filme_id
group by i.titulo
order by quant_atores desc;

----------------------------------------------------